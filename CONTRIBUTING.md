# Contributing Guide

> This guide covers the development workflow from issue to release: issue-driven work, tests alongside code, and a clean Git history. For the tech stack and setup, see `README.md`. For AI agent instructions, see `AGENTS.md`.

## Quick Start

1. **Issue → Branch**: Create an issue, then start a branch with the script.
2. **Develop with tests**: Write tests, implement, and commit in the approved format.
3. **Submit & Review**: Clean up commits, open a PR, get approval, and a maintainer merges.

**Key requirements**

- All work starts with a GitHub Issue
- New behavior ships with tests (≥80% coverage for new code)
- Clean Git history before the PR (squash and rebase)
- You are accountable for everything you submit, whether written by you or by AI

---

## Step 1: Issue → Branch

### Create the issue first

Every change needs a GitHub Issue for tracking. Use the `AI Assist Issue` template if helpful (see `docs/AI_ISSUE_ASSISTANT.md`). For large features, create an Epic with sub-issues sized at roughly 1-2 days each.

### Start the branch

Always use the script:

```bash
./scripts/start_issue.sh <issue-number>
```

It creates a branch named `<issue-number>-<slugified-title>`, assigns the issue to you, and checks out the branch.

---

## Step 2: Develop with Tests

### Tests

Define expected behavior in tests, then implement. Writing tests first is the preferred approach, but what matters is that tests exist and pass before review.

- **Unit tests:** ≥80% coverage for new code
- **Integration tests:** required for APIs and complex workflows
- **E2E tests:** required for critical user journeys
- **Location:** put test files next to their targets (e.g. `Button.js` and `Button.test.js`)

### Code standards

- Follow the linter and formatter configured in the repo. CI enforces them.
- Comment the *why*, not the *what*. Document public APIs and non-obvious logic.
- Keep files and functions focused on one responsibility.
- Don't leave dead code or commented-out code behind.

### Commit message format (enforced)

**Format:** `type(scope): description #issue-number`

Your first commit message must match the PR title: `<issue-title> #<issue-number>`. Get the exact title with:

```bash
./scripts/get_issue_title.sh <issue-number>
```

**Approved types**

| Type       | Use for                                                                               |
| ---------- | ------------------------------------------------------------------------------------- |
| `feat`     | New features and user-facing improvements, including performance (added to Changelog) |
| `fix`      | Bug fixes and security patches (added to Changelog)                                   |
| `docs`     | Documentation-only changes                                                            |
| `chore`    | Build, CI/CD, dependencies, tooling                                                   |
| `refactor` | Code restructuring, formatting, and test changes with no behavior change              |

**Rules**

- Header ≤100 characters
- Lowercase scope
- No period at the end
- Must include the issue number (except `chore(main):` commits)

**Examples**

```bash
✅ feat(auth): implement OAuth login system #123
✅ fix(payment): resolve gateway timeout issue #789
✅ docs(readme): update installation guide #321
✅ chore(deps): upgrade React to v18.2.0 #987
✅ refactor(utils): simplify date formatting functions #246

❌ feat(AUTH): implement login #123    (scope must be lowercase)
❌ feat(auth): implement login. #123   (no period at end)
❌ feat(auth): implement login         (missing issue number)
❌ style(auth): fix indentation #123   (use refactor)
❌ build(deps): update package #123    (use chore)
```

---

## Step 3: Submit & Review

### Clean commit history (mandatory)

Before opening the PR, turn your working commits into a small set of meaningful ones. Small issues are usually 1 commit; larger ones may have several logical commits (e.g. feat + docs + chore).

```bash
./scripts/squash_commits.sh
```

The script rebases onto `main`, helps you squash interactively, lets you edit the final message, and safely force-pushes.

### Create the PR

- **Title:** must match `<issue-title> #<issue-number>`
- **Body:** fill in `.github/PULL_REQUEST_TEMPLATE.md`. Write it yourself or have your AI tool draft it, but review it for accuracy.

```bash
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body "<filled-in template>" \
  --base main \
  --push
```

For long bodies, use `--body-file <path>` with a temporary file and delete it afterwards.

### PR template guidelines

- Be honest about the checklist. Don't check items you didn't do.
- Explain how you tested the change.
- Use Reviewer Notes to point reviewers at risky or unclear areas.
- Disclose AI assistance in the AI Assistance section.

### Pre-submission checklist

- [ ] Commits cleaned up, each with an issue number and an approved type
- [ ] Tests pass locally and the build succeeds
- [ ] Code is formatted and lint-clean
- [ ] You have read and understood every line of the diff
- [ ] PR title and body are complete

### Review and merge

1. CODEOWNERS are automatically assigned as reviewers.
2. Address feedback promptly.
3. All CI checks must pass and at least one approval is required.
4. Only **"Rebase and merge"** is allowed, and a maintainer performs the merge.
5. The branch is auto-deleted after merge, and commits land on `main` exactly as they exist on your branch.

---

## Working with AI

AI tools (Copilot, Claude, Cursor, agents, etc.) are welcome and encouraged. The same standards apply to AI-assisted work as to anything else.

- **You are the author.** Review AI output for correctness, security, and fit with the codebase before committing. "The AI wrote it" is not a defense for a bug.
- **Give it context.** Point AI tools at `README.md` and `AGENTS.md`. Keep `AGENTS.md` current when conventions change, because that file is the source of truth for agents, not this guide.
- **Disclose in the PR.** Check the AI Assistance section of the PR template when AI contributed significantly.
- **Don't paste secrets or private data** into AI tools.
- **Keep PRs reviewable.** AI makes large diffs cheap to produce, but reviewers still have to read them. Split big changes into focused PRs.

---

## Getting Help

Ask early if you're unsure about requirements, approach, or conventions. Comment on the issue, tag the relevant people, and include what you've tried and what specifically you need.

---

## Reference

- `README.md`: project overview, tech stack, setup
- `AGENTS.md`: instructions for AI agents
- `docs/AI_ISSUE_ASSISTANT.md`: issue creation guidance
- `docs/AI_PULL_REQUEST_ASSISTANT.md`: PR creation guidance

---

**Success criteria:** Every change is traceable to an issue, covered by passing tests, and lands on `main` as a clean, well-labeled commit history.