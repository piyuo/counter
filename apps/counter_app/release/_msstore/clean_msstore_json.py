#!/usr/bin/env python3
"""
Clean up a Microsoft Store submission JSON so it only contains:
  - Id
  - Listings
      - <every locale key>
          - BaseListing
              - ReleaseNotes

Usage:
    python clean_msstore_json.py meta.json release_notes.json
"""

import json
import sys


def clean_msstore_json(input_path: str, output_path: str) -> None:
    with open(input_path, "r", encoding="utf-8") as f:
        data = json.load(f)

    cleaned = {
        "Id": data.get("Id"),
        "Listings": {},
    }

    listings = data.get("Listings", {})
    for locale, listing in listings.items():
        base_listing = listing.get("BaseListing", {}) or {}
        cleaned["Listings"][locale] = {
            "BaseListing": {
                "ReleaseNotes": base_listing.get("ReleaseNotes", "")
            }
        }

    with open(output_path, "w", encoding="utf-8") as f:
        json.dump(cleaned, f, ensure_ascii=False, indent=2)

    print(f"Done. {len(cleaned['Listings'])} locale(s) written to {output_path}")


if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python clean_msstore_json.py <input.json> <output.json>")
        sys.exit(1)

    clean_msstore_json(sys.argv[1], sys.argv[2])