# Contributing Guidelines

We follow a **simplified GitHub Flow** with **rebase and merge** strategy for clean commit history and milestone-driven releases.

## 📋 Quick Start

Here's the complete workflow at a glance:

1. **Create Issue** → Select milestone, use templates, estimate effort
2. **Create Branch** → From main, using GitHub's branch creation feature
3. **Open Draft PR** → Enable early collaboration with reviewers
4. **Develop & Commit** → Frequent commits with descriptive messages
5. **Clean History** → Squash into meaningful commits before requesting review
6. **Request Review** → Convert to ready PR, address feedback
7. **Merge** → Maintainer performs rebase and merge
8. **Auto-Release** → When milestone complete, release-please handles versioning

For detailed instructions, see the sections below:

- [AI Integration Schema](#-ai-integration-schema)
- [Workflow Overview](#workflow-overview)
- [Issue and Milestone Management](#issue-and-milestone-management)
- [Development Process](#development-process)
- [Commit Management](#commit-management)
- [Pull Request Process](#pull-request-process)
- [Release Management](#release-management)
- [Code Standards](#code-standards)

## 🔄 Workflow Overview

Our workflow emphasizes **meaningful commit history** and **milestone-driven releases**:

```mermaid
gitGraph
    commit id: "v1.0.0"
    branch issue-17-fix-auth
    checkout issue-17-fix-auth
    commit id: "WIP: auth changes"
    commit id: "fix: typo"
    commit id: "refactor: cleanup"
    checkout main
    merge issue-17-fix-auth id: "fix: authentication bug in login flow #17"
    branch issue-25-add-feature
    checkout issue-25-add-feature
    commit id: "feat: implement core logic"
    commit id: "feat: add validation layer"
    checkout main
    merge issue-25-add-feature id: "feat: add user dashboard feature #25"
    commit id: "v1.1.0"
```

### Key Principles
- **Meaningful commits on main** - avoid WIP, typo fixes, and noisy commits
- **Rebase and merge only** - no merge commits
- **Milestone-driven releases** - all issues must belong to a milestone
- **Draft PRs for early collaboration** with reviewers
- **Clear PR-Issue linking** - PR titles must include issue number

## 📊 Issue and Milestone Management

### Creating Issues
All work must begin with a GitHub Issue:

1. **Select milestone first** - Choose from available milestones
2. **Use issue templates** - Choose between:
   - **🐛 Bug Report** - For reporting bugs and issues
   - **✨ Feature Request** - For suggesting new features or improvements
3. **Complete required fields**:
   - **Bug Report**: Description, reproduction steps, expected/actual behavior, severity, version, OS
   - **Feature Request**: Problem statement, proposed solution, priority
4. **Add optional details** as helpful (screenshots, logs, additional context)
5. **Estimate effort** - Use story points (1 point ≈ 2 hours, max 20 points per week)

### Large Feature Management
For complex features, we use **Epic + Sub-issues** approach:

1. **Epic Issue** - Main feature request with overview and background
2. **Team Planning** - Collaborative breakdown into sub-issues (1-2 days each)
3. **Sub-issue Creation** - Each with clear acceptance criteria
4. **Team Assignment** - Developers claim specific sub-issues
5. **Coordinated Development** - All sub-issues tracked in project board

#### Issue Types and Commit Prefixes:
| Issue Type        | Template            | Commit Prefix       | Version Impact   | Example                                                                   |
| ----------------- | ------------------- | ------------------- | ---------------- | ------------------------------------------------------------------------- |
| 🐛 Bug Report      | `🐛 Bug Report`      | `fix:`              | Patch            | `fix: resolve payment gateway timeout`                                    |
| ✨ Feature Request | `✨ Feature Request` | `feat:` or `feat!:` | Minor or Major** | `feat: add user profile management`<br>`feat!: migrate to new API format` |
| Documentation     | Manual creation     | `docs:`             | None*            | `docs: update API authentication guide`                                   |

*\*Does not trigger version bumps by release-please*

*\*\*Feature Requests can result in either regular features (`feat:` → minor bump) or breaking changes (`feat!:` → major bump) depending on implementation impact*

### Milestone Management
- **All issues must have a milestone** assigned before starting work
- **Milestones represent development cycles** - e.g., "Sprint 7 - Payment Integration"
- **Version numbers determined by release-please** based on commit types
- **Release when milestone complete** - all issues closed

## 🚀 Development Process

### 1. Create Issue Branch
1. Navigate to your assigned GitHub Issue
2. Click "Create a branch for this issue"
3. **Source**: Always branch from `main`
4. **Naming**: GitHub auto-generates (e.g., `17-fix-payment-gateway`)

### 2. Start with Draft PR (Recommended)
Create a **Draft PR** immediately for early collaboration:

```bash
# After first commit
git push -u origin <branch-name>
# Create Draft PR on GitHub
```

**Benefits of Draft PRs:**
- Early feedback from CODEOWNERS reviewers
- Discuss approach before implementation
- Avoid large changes at review time
- Track progress transparently

### 3. Development and Commits
During development, commit frequently with any messages you find helpful:

```bash
# Examples of work-in-progress commits (these will be cleaned up later)
git commit -m "WIP: initial authentication setup"
git commit -m "add password validation logic"
git commit -m "fix: handle edge case for empty passwords"
git commit -m "refactor: extract validation functions"
git commit -m "docs: add authentication flow diagram"
git commit -m "fix typo in error message"
git commit -m "debug: add logging for troubleshooting"
```

**Development Phase Freedom:**
- Commit as frequently as you want with any message style
- Use WIP, debug, typo fix, or any other commit messages
- Focus on progress, not commit message perfection
- These commits will be cleaned up before review

## 📝 Commit Management

### Before Requesting Review (Critical Step)

**You MUST clean up your commit history** before creating a PR or converting Draft PR to ready for review.

#### Option 1: Command Line (Traditional)
```bash
# First, sync with latest main
git fetch origin
git rebase origin/main

# Clean up commits using interactive rebase
git rebase -i origin/main
```

#### Option 2: Visual Studio Code Git Graph (Recommended)
For developers using VS Code, the **Git Graph extension** provides a more intuitive UI approach:

1. **Install Git Graph extension** (if not already installed)
2. **Open Git Graph** - Click the graph icon in Source Control panel
3. **Reset to clean point**:
   - Right-click on the latest `main` commit
   - Select "Reset current branch to this Commit"
   - Choose "**Soft - Keep all changes, but reset head**"
   - This preserves all your work but removes commit history
4. **Create meaningful commits**:
   - Stage and commit your changes as clean, meaningful commits
   - Follow the commit format: `<type>: <description> #<issue-number>`
5. **Force push safely**:
   - Right-click on your branch in Git Graph
   - Select "**Push branch - Force With Lease**"
   - This safely updates your remote branch

**Benefits of Git Graph approach:**
- Visual representation of commit history
- Point-and-click interface for complex git operations
- Safer force-push with built-in conflict detection
- No need to remember git rebase commands

### Commit Cleanup Guidelines

**Goal**: Transform messy development commits into **1-n meaningful commits** (typically 1 per issue).

**What to squash/remove:**
- ❌ WIP commits
- ❌ Typo fixes
- ❌ Debug commits
- ❌ "Fix review comments"
- ❌ Any noisy, non-meaningful commits

**What constitutes meaningful commits:**
- ✅ `feat: implement user authentication system #17`
- ✅ `fix: resolve payment gateway timeout issues #142`
- ✅ `refactor: optimize database query performance #201`
- ✅ `docs: add API authentication guide #78`

### Interactive Rebase Example
```bash
# Before cleanup (messy development history):
pick abc1234 WIP: start auth work
pick def5678 add validation
pick ghi9012 fix typo in validation
pick jkl3456 debug: add more logging
pick mno7890 fix: handle edge cases
pick pqr1234 remove debug logging
pick stu5678 final cleanup

# After cleanup (meaningful history):
pick abc1234 feat: implement user authentication with validation #17
```

**For Complex Features:**
You may keep multiple meaningful commits if they represent distinct logical units:
```bash
# Acceptable for complex features:
feat: implement OAuth2 authentication core #17
feat: add user session management #17
docs: add authentication flow documentation #17
```

### Final Commit Requirements
Your cleaned commits must follow these requirements:

- **Use conventional commit format**: `<type>: <description> #<issue-number>`
- **Must be `feat:` or `fix:`** to trigger version updates (unless it's docs/refactor/chore)
- **Include issue number** for traceability
- **Be descriptive and actionable**

#### Good Examples:
```bash
feat: add user dashboard with activity metrics #95
fix: resolve payment gateway connection timeout #142
refactor: optimize database query performance for large datasets #201
```

#### Bad Examples:
```bash
WIP: working on dashboard  # ❌ Not meaningful
Update code  # ❌ Not descriptive, no issue number
fix typo  # ❌ Noisy commit that should be squashed
```

## 🔀 Pull Request Process

### Before Creating/Converting PR

**MANDATORY STEPS:**

1. **Clean up your commits** (see Commit Management section above)
2. **Sync with main branch**:
```bash
git fetch origin
git rebase origin/main
git push --force-with-lease origin <branch-name>
```
3. **Run all tests and linting** locally

### Creating the PR

Use our **PR template** which includes:

**Required Sections:**
- **Checklist** - Code standards, testing, documentation
- **Testing** - How changes were tested, evidence provided
- **Deployment Notes** - Any special deployment considerations
- **Reviewer Notes** - Specific areas for review focus

**Template automatically populated** when creating PR from issue branch.

#### PR Title Format:
```
<type>: <description> #<issue-number>
```

**IMPORTANT**: PR title must include the issue number for proper linking and traceability.

**Examples:**
```bash
feat: add user dashboard with activity metrics #95
fix: resolve payment gateway connection timeout #142
docs: update API authentication guide #78
refactor: optimize database query performance #201
```

### Review Process

1. **CODEOWNERS automatically assigned** as reviewers
2. **Address feedback promptly**:
   ```bash
   # Address review feedback with additional commits
   git commit -m "address review: improve error handling per feedback"
   git commit -m "fix: update tests based on reviewer suggestions"
   ```
3. **All CI checks must pass** before merge
4. **At least one approval required** from CODEOWNERS

### Merge Timing and Responsibilities

**Key Understanding:**
- **Reviewers decide when to merge** - once they approve, they typically merge immediately
- **No additional cleanup opportunity** after review approval
- **Reviewers may request commit cleanup** as part of their review if they notice noisy commits
- **Developer responsibility**: Ensure commits are clean BEFORE requesting review

**Review Scenarios:**

**Scenario 1: Clean commits submitted**
```
✅ Developer submits PR with meaningful commits
✅ Reviewer approves and merges immediately
✅ Clean history preserved on main
```

**Scenario 2: Noisy commits detected**
```
❌ Developer submits PR with WIP/typo commits
🔍 Reviewer requests: "Please clean up commits before merge"
🛠️ Developer rebases and force-pushes cleaned history
✅ Reviewer re-approves and merges
```

### Merge Process

- **Only "Rebase and merge" allowed** - other options are disabled
- **Maintainer performs the merge** after approval
- **Commits appear on main exactly as they exist on feature branch**
- **Branch automatically deleted** after merge

## 🏷️ Release Management

### Understanding Release-Please

**Release-please** is an automated tool that handles versioning and releases by:

1. **Analyzing commit messages** on main branch
2. **Determining version type** based on conventional commits:
   - `feat:` commits → Minor version bump (1.1.0 → 1.2.0)
   - `fix:` commits → Patch version bump (1.1.0 → 1.1.1)
   - `feat!:` or `BREAKING CHANGE` → Major version bump (1.1.0 → 2.0.0)
3. **Generating changelog** from commit messages and linked issues
4. **Creating release PR** with version bump and changelog
5. **Creating Git tags** when release PR is merged

### Milestone Completion
When all issues in a milestone are completed:

1. **Release-please creates release PR** automatically
2. **Maintainer reviews and merges** release PR to main
3. **Automatic version bump and changelog** generation
4. **Git tag created** with version number
5. **CI/CD deployment triggered** automatically

### Version Strategy
Following **semantic versioning** (semver):

- **feat:** commits → Minor version bump (1.1.0 → 1.2.0)
- **fix:** commits → Patch version bump (1.1.0 → 1.1.1)
- **feat!:** or **BREAKING CHANGE** → Major version bump (1.1.0 → 2.0.0)
- **docs/refactor/chore:** → No version bump

## 💡 Code Standards

### Quality Requirements
- **All linting warnings resolved** before review
- **Test coverage ≥ 80%** for new code
- **Unit tests required** for business logic
- **Integration tests required** for APIs

### Naming Conventions
- **Variables**: camelCase (JS/Dart) or snake_case (Python)
- **Functions**: Descriptive verbs (`getUserById`, `calculateTotal`)
- **Classes**: PascalCase (`UserService`, `PaymentGateway`)
- **Files**: kebab-case (`user-service.js`, `payment-gateway.py`)

### Best Practices
- **Functions under 20 lines** (max 50 lines)
- **Single responsibility principle**
- **Maximum 3 levels of nesting**
- **Meaningful comments explain why, not what**
- **Remove dead code** before PR

## 🛠️ Common Git Operations

### Interactive Rebase Example (Command Line)
```bash
# Start interactive rebase (make sure to fetch first)
git fetch origin
git rebase -i origin/main

# In the editor, squash noisy commits:
pick abc1234 feat: implement user authentication #17
squash def5678 WIP: add validation
squash ghi9012 fix typo in validation
squash jkl3456 remove debug logging

# Edit the final commit message to be meaningful:
# feat: implement user authentication with validation #17
```

### Git Graph Alternative (Visual Studio Code)
For VS Code users, commit cleanup can be done visually:

1. **View commit history** in Git Graph extension
2. **Identify cleanup point** - usually the last commit from main
3. **Soft reset** to that point (keeps all changes)
4. **Re-commit cleanly** with meaningful messages
5. **Force push with lease** to update remote branch

### Handling Review Changes
```bash
# After reviewer approval, they merge immediately
# No opportunity for additional cleanup

# If reviewer requests commit cleanup:
git rebase -i origin/main  # Clean up commits
git push --force-with-lease origin <branch-name>  # Update PR
# Reviewer will then re-review and merge
```

## 🔍 Enhanced Traceability with Issue Linking

With our improved PR title format, traceability is significantly enhanced:

### Complete Traceability Chain
```
Issue #93 → Branch 93-docs-update → PR #94 "docs: update contributing guide #93" → Commit "docs: update contributing guide #93"
```

### Finding Related Content
1. **From main branch commit**: Issue number is directly visible in commit message
2. **From commit to PR**: Click the `#PR-NUMBER` link below commit title
3. **From PR to issue**: Issue number in PR title links directly to original issue
4. **Reverse lookup**: GitHub automatically shows all PRs that reference an issue

### Benefits of Enhanced Linking
- **Instant issue identification** from any commit on main branch
- **Streamlined code archaeology** - easily trace why changes were made
- **Automated issue closing** - GitHub closes issues when PR with `#issue-number` is merged
- **Better project management** - clear visibility of which issues are in progress/completed
- **Improved changelog generation** - release notes can include issue context

## 🤔 FAQ

**Q: When exactly should I clean up my commits?**
A: **Before creating a PR or converting Draft PR to ready for review**. This is mandatory - reviewers expect clean, meaningful commits.

**Q: Can I keep WIP commits in my PR?**
A: **No**. All WIP, typo fixes, debug commits, and other noisy commits must be squashed before review. Use interactive rebase to clean them up.

**Q: What if reviewers ask for changes after I submit clean commits?**
A: Make the requested changes in new commits. Reviewers will merge when satisfied - there's typically no opportunity for you to clean up review feedback commits before merge.

**Q: Do I need exactly one commit per PR?**
A: **No**. You need **1-n meaningful commits**. Simple issues typically result in 1 commit, but complex features can have multiple logical commits (e.g., core implementation + documentation + tests).

**Q: What's the easiest way to clean up commits if I'm not comfortable with git rebase?**
A: **Use Visual Studio Code's Git Graph extension**. It provides a visual interface where you can:
1. Right-click on main's latest commit → "Reset current branch to this Commit" → "Soft"
2. This keeps all your changes but cleans the commit history
3. Create new meaningful commits with proper messages
4. Force push with lease to update your branch

This is much more intuitive than interactive rebase for beginners.

**Q: Why is commit cleanup so important?**
A: Because commits go directly to main branch via rebase-and-merge. The main branch history becomes our project's permanent record and is used by release-please for changelog generation.

**Q: What's the difference between "squash all into one" vs "meaningful commits"?**
A:
- ❌ **Squash everything**: Forces all work into exactly 1 commit regardless of complexity
- ✅ **Meaningful commits**: Keep logically distinct work separate, remove noise

**Examples:**
```bash
# Complex feature with meaningful commits:
feat: implement OAuth2 authentication core #17
feat: add session management and user profiles #17
docs: add authentication setup guide #17

# Simple bug fix:
fix: resolve payment gateway timeout issue #17
```

**Q: Can I work on multiple issues simultaneously?**
A: Yes, but each must have its own branch and milestone assignment.

**Q: What happens if CI fails after merge?**
A: Create a hotfix issue and follow the same process. No direct commits to main allowed.

**Q: How do I handle breaking changes?**
A: Use the exclamation mark syntax in your commit type to trigger a major version bump:

```bash
# Breaking change examples:
feat!: change user ID from int to UUID #123

# Or with detailed explanation:
feat!: migrate authentication to OAuth 2.0 #456

BREAKING CHANGE: Previous API key authentication is no longer supported.
Users must migrate to OAuth 2.0 authentication flow.
```

**Q: How do we handle large features?**
A: Use Epic + Sub-issues approach. Team collaboratively breaks down the epic into 1-2 day sub-issues, each developer claims specific sub-issues and creates their own branch + PR.

**Q: What about hotfixes for production issues?**
A: We don't use hotfix branches. All changes follow the standard workflow. Production issues are handled at the deployment level using CI/CD rollback capabilities.

**Q: Why should I use `git rebase -i origin/main` instead of `git rebase -i main`?**
A: Using `origin/main` ensures you're rebasing against the latest remote version of main, and it only affects commits unique to your feature branch.

## 🤖 AI Integration Schema

To support AI-powered development tools, here are the machine-readable format standards:

### Commit Format Schema
```yaml
commit:
  format: "<type>: <description> #<issue>"
  types:
    - feat      # New features (minor version bump)
    - fix       # Bug fixes (patch version bump)
    - docs      # Documentation changes (no version bump)
    - refactor  # Code refactoring (no version bump)
    - chore     # Maintenance tasks (no version bump)
  breaking_change:
    format: "<type>!: <description>"
    description: "Use exclamation mark for major version bumps"
  cleanup_required: true
  cleanup_timing: "Before creating PR or converting Draft to ready"
  examples:
    - "feat: add user dashboard with activity metrics #95"
    - "fix: resolve payment gateway timeout issues #142"
    - "feat!: migrate to OAuth 2.0 authentication #78"
```

### PR Title Schema
```yaml
pr_title:
  regex: "^(feat|fix|docs|refactor|chore)(!)?:\\s.+\\s#[0-9]+$"
  format: "<type>: <description> #<issue-number>"
  required_fields:
    - type: Must match commit types
    - description: Clear, actionable description
    - issue_number: GitHub issue reference
  examples:
    - "feat: add user dashboard with activity metrics #95"
    - "fix: resolve payment gateway connection timeout #142"
```

### Commit Cleanup Schema
```yaml
commit_cleanup:
  timing: "Before PR creation or Draft conversion to ready"
  mandatory: true
  goal: "1-n meaningful commits per issue"
  remove_commits:
    - "WIP commits"
    - "Typo fixes"
    - "Debug commits"
    - "Temporary commits"
  keep_commits:
    - "Logical feature implementations"
    - "Distinct bug fixes"
    - "Documentation additions"
    - "Refactoring improvements"
  tools:
    - "git rebase -i origin/main"
    - "Interactive rebase for squashing"
```

### PR Description Schema
```yaml
pr_description:
  required_sections:
    - checklist:
        - "Code follows project style guidelines"
        - "Self-review completed"
        - "Tests added/updated and passing"
        - "Documentation updated"
        - "Commits cleaned up and meaningful"
    - testing:
        description: "How changes were tested with evidence"
        required: true
    - deployment_notes:
        description: "Special deployment considerations"
        required: false
    - reviewer_notes:
        description: "Specific areas for review focus"
        required: false
  template_auto_populated: true
```

### Issue Schema
```yaml
issue:
  required_fields:
    - milestone: "Must be assigned before starting work"
    - template: "🐛 Bug Report or ✨ Feature Request"
    - estimation: "Story points (1 point ≈ 2 hours, max 20 points/week)"
  templates:
    bug_report:
      name: "🐛 Bug Report"
      labels: ["type: bug", "needs-triage"]
      required_fields:
        - description: "Clear bug description"
        - reproduction: "Steps to reproduce"
        - expected: "Expected behavior"
        - actual: "Actual behavior"
        - severity: "Low/Medium/High/Critical"
        - version: "Software version"
        - os: "Operating system"
      optional_fields:
        - browser: "Browser (if applicable)"
        - logs: "Error messages/logs"
        - screenshots: "Visual evidence"
        - additional: "Additional context"
      commit_type: "fix"
      version_impact: "patch"
    feature_request:
      name: "✨ Feature Request"
      labels: ["type: feature", "needs-triage"]
      required_fields:
        - problem: "Problem statement"
        - solution: "Proposed solution with acceptance criteria"
        - priority: "Low/Medium/High/Critical"
      optional_fields:
        - additional: "Additional context, mockups, examples"
      commit_type: "feat or feat!"
      version_impact: "minor or major (depending on breaking changes)"
```

---

**Remember**: Clean, meaningful commits before review - this is your only opportunity to ensure main branch history stays clean! 🧹✨🔗