#!/usr/bin/env python3
"""
fix_meta_json.py

Fixes meta.json files that fail to parse because they contain raw/literal
newline characters (and other control characters) inside string values,
instead of properly-escaped \\n sequences.

Usage:
    python fix_meta_json.py meta.json                # writes meta.fixed.json
    python fix_meta_json.py meta.json -o out.json     # custom output path
    python fix_meta_json.py meta.json --in-place      # overwrite original
"""

import argparse
import json
import re
import sys


def try_parse(text: str):
    """Try to parse text as JSON. Return (data, None) or (None, error)."""
    try:
        return json.loads(text), None
    except json.JSONDecodeError as e:
        return None, e


def escape_control_chars_in_strings(text: str) -> str:
    """
    Walk the raw text character by character. Whenever we're inside a
    JSON string (between unescaped double quotes), replace raw control
    characters (newline, tab, carriage return, etc.) with their proper
    JSON-escaped form. This fixes the classic case where a JSON file
    was produced with literal newlines embedded in string values.
    """
    out = []
    in_string = False
    escaped = False

    replacements = {
        "\n": "\\n",
        "\r": "\\r",
        "\t": "\\t",
    }

    for ch in text:
        if in_string:
            if escaped:
                out.append(ch)
                escaped = False
                continue
            if ch == "\\":
                out.append(ch)
                escaped = True
                continue
            if ch == '"':
                in_string = False
                out.append(ch)
                continue
            if ch in replacements:
                out.append(replacements[ch])
                continue
            # other control chars (rare) -> unicode escape
            if ord(ch) < 0x20:
                out.append("\\u%04x" % ord(ch))
                continue
            out.append(ch)
        else:
            if ch == '"':
                in_string = True
            out.append(ch)

    return "".join(out)


def dewrap_hard_wrapped_strings(text: str) -> str:
    """
    Handles files that were hard-wrapped at a fixed column width (common
    when JSON is exported/copied through a text editor or terminal that
    inserts a real newline wherever a line got too long). This breaks
    JSON in two ways:

      1. A newline lands in the middle of ordinary text, e.g.:
         "...for users who need \naccurate foot traffic..."
         -> should just be "...for users who need accurate foot traffic..."

      2. A newline lands in the middle of a \\uXXXX escape sequence, e.g.:
         "\\u60\nA8"  -> should be "\\u60A8"

    This walks the text as a real JSON-escape-aware scanner: raw newlines
    found while collecting the 4 hex digits of a \\uXXXX escape are
    deleted outright (they're mid-token, so no space belongs there); raw
    newlines found elsewhere inside a string are collapsed into a single
    space (rejoining the wrapped words), swallowing any further
    consecutive whitespace/newlines so we don't end up with double spaces.
    """
    out = []
    in_string = False
    i = 0
    n = len(text)
    hex_digits = "0123456789abcdefABCDEF"

    while i < n:
        ch = text[i]

        if not in_string:
            if ch == '"':
                in_string = True
            out.append(ch)
            i += 1
            continue

        # in_string is True
        if ch == "\\" and i + 1 < n:
            # The wrap might have inserted whitespace right after the
            # backslash too (before we even see which escape type it
            # is), e.g. "\<newline>u60A8" instead of "\u60A8". Skip any
            # such wrap whitespace before reading the escape-type char.
            j = i + 1
            while j < n and text[j] in "\n\r\t":
                j += 1

            if j >= n:
                out.append(ch)
                i += 1
                continue

            nxt = text[j]
            if nxt == "u":
                out.append("\\u")
                i = j + 1
                collected = []
                while len(collected) < 4 and i < n:
                    c2 = text[i]
                    if c2 in hex_digits:
                        collected.append(c2)
                        i += 1
                    elif c2 in "\n\r\t ":
                        # wrap artifact splitting the escape - drop it
                        i += 1
                    else:
                        # unexpected char mid-escape; stop and let it be
                        break
                out.append("".join(collected))
                continue
            else:
                # any other valid escape (\", \\, \/, \b, \f, \n, \r, \t)
                out.append("\\")
                out.append(nxt)
                i = j + 1
                continue

        if ch == '"':
            in_string = False
            out.append(ch)
            i += 1
            continue

        if ch in "\n\r\t":
            prev = out[-1] if out else ""
            if prev != " ":
                out.append(" ")
            i += 1
            # swallow any further consecutive wrap whitespace
            while i < n and text[i] in "\n\r\t ":
                i += 1
            continue

        out.append(ch)
        i += 1

    return "".join(out)


def collapse_literal_backslash_n(text: str) -> str:
    """
    Handles the OTHER common variant: the file contains the two literal
    characters backslash + n (i.e. the text `\\n`) where it was meant to
    just be a real newline for display purposes but somehow duplicated
    or mismatched escaping broke things (e.g. `\\\\n`). This normalizes
    double-escaped newlines back to single-escaped.
    """
    return text.replace("\\\\n", "\\n").replace("\\\\r", "\\r").replace("\\\\t", "\\t")


def fix_json_text(raw_text: str):
    """
    Try a series of increasingly aggressive fixes and return the first
    one that produces valid JSON, along with the parsed data.
    """
    attempts = [
        ("as-is", raw_text),
        ("de-wrap hard-wrapped strings (space-join, escape-aware)", dewrap_hard_wrapped_strings(raw_text)),
        ("escape raw control chars inside strings", escape_control_chars_in_strings(raw_text)),
        ("collapse double-escaped newlines", collapse_literal_backslash_n(raw_text)),
        (
            "escape raw control chars + collapse double-escaped",
            escape_control_chars_in_strings(collapse_literal_backslash_n(raw_text)),
        ),
    ]

    for label, candidate in attempts:
        data, err = try_parse(candidate)
        if data is not None:
            return data, candidate, label, None

    # If nothing worked, return the last error for diagnostics
    _, err = try_parse(attempts[-1][1])
    return None, attempts[-1][1], None, err


def main():
    parser = argparse.ArgumentParser(description="Fix malformed newlines in a JSON file.")
    parser.add_argument(
        "input", nargs="?", default="meta.origin.json", help="Path to the broken JSON file (default: meta.origin.json)"
    )
    parser.add_argument("-o", "--output", default="meta.json", help="Path to write the fixed JSON file (default: meta.json)")
    parser.add_argument(
        "--in-place", action="store_true", help="Overwrite the input file instead of writing a new one"
    )
    args = parser.parse_args()

    # encoding="utf-8-sig" transparently strips a leading UTF-8 BOM
    # (byte-order mark) if present, and behaves like plain utf-8 otherwise.
    with open(args.input, "r", encoding="utf-8-sig", errors="replace") as f:
        raw_text = f.read()

    data, fixed_text, label, err = fix_json_text(raw_text)

    if data is None:
        print("Could not automatically fix the JSON. Last error:", file=sys.stderr)
        print(f"  {err}", file=sys.stderr)
        # Show a snippet around the error position to help debugging
        if err is not None:
            pos = err.pos
            start = max(0, pos - 80)
            end = min(len(fixed_text), pos + 80)
            print("\nContext around the error:\n", file=sys.stderr)
            print(fixed_text[start:end], file=sys.stderr)
        sys.exit(1)

    print(f"Fixed successfully using strategy: '{label}'")

    if args.in_place:
        out_path = args.input
    else:
        out_path = args.output

    with open(out_path, "w", encoding="utf-8") as f:
        json.dump(data, f, ensure_ascii=False, indent=2)

    print(f"Wrote valid JSON to: {out_path}")


if __name__ == "__main__":
    main()