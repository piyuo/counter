# Contributing Guide

> **Complete Development Workflow:** This guide covers the entire development lifecycle from issue creation to automated releases, following a test-first approach with clean Git history.

**Note:** Code examples use JavaScript for demonstration. For actual tech stack, see README.md.

## 📋 Table of Contents & Quick Start

### 🚀 Core Workflow (3 Steps)

1. **[📋 Issue → Branch](#-step-1-issue--branch)** → Create issue, start branch
2. **[✅ Test-First Development](#-step-2-test-first-development)** → Write tests, develop, commit
3. **[🔀 Submit & Review](#-step-3-submit--review)** → Clean commits, create PR, get approval, merge

### Guidelines & Standards

- [📝 PR Guidelines](#-pr-guidelines)
- [Code Standards & AI-Friendly Structure](#code-standards)
- [Commit Message Format](#commit-message-format-enforced)

### Support & Reference

- [🆘 Getting Help](#-getting-help)
- [❓ FAQ](#-faq)
- [🚨 Common Pitfalls](#-common-pitfalls)
- [📚 Reference Documents](#-reference-documents)

### Key Requirements

- **Test-First Development**: Write tests before code (≥80% coverage)
- **Clean Git History**: Squash commits before PR submission
- **AI-Friendly Files**: Include TOC/Overview at top of all files
- **Issue-Driven**: All work must start with GitHub Issue

---

## 📋 Step 1: Issue → Branch

### Create Issue First

All work must begin with a GitHub Issue for proper tracking.

**Recommended:** Use the AI-powered issue template `AI Assist Issue` (see `docs/AI_ISSUE_ASSISTANT.md`)

**For large features:** Create Epic + Sub-issues (1-2 days each)

### Start Issue Branch

**ALWAYS** use the provided script:

```bash
./scripts/start_issue.sh <issue-number>
```

This script:

- Creates branch named `<issue-number>-<slugified-title>`
  **Example:** Issue #71 "Update Draft PR workflow documentation" → `71-docs-update-draft-pr-workflow-documentation-to-reflect-correct-process`
- Assigns issue to you
- Checks out the new branch

---

## ✅ Step 2: Test-First Development

### Write Tests First (MANDATORY)

Before writing any code, write tests that define expected behavior.

**Why:** This ensures code is testable, considers edge cases upfront, and provides immediate feedback.

**Requirements:**

- Unit Tests: ≥80% coverage for new code
- Integration Tests: Required for APIs and complex workflows
- E2E Tests: Required for critical user journeys

### Test File Structure

Put `.test` files next to their targets:

```text
src/
├── components/
│   ├── Button/
│   │   ├── Button.js
│   │   └── Button.test.js
├── pages/
│   ├── about/
│   │   ├── index.js
│   │   └── index.test.js
```

### Development Phase

**Step 1: Write Tests & Develop**

Write tests first, then implement the functionality to make tests pass:

```bash
# Write tests first
# Implement functionality
# Continue iterating with tests and code
```

**Step 2: Commit During Development**

create your first commit with the proper format:

```bash

# Get the exact issue title for consistency
./scripts/get_issue_title.sh <issue-number>

# Example first commit - this will become your PR title
git commit -m "<issue-title> #<issue-number>"
```

**IMPORTANT:** This first commit message will be used as your PR title

## Commit Message Format (ENFORCED)

Always reference the issue number in the commit. Use one of the 5 approved commit types:

**Format:** `type(scope): description #issue-number`

### Approved Commit Types

- **`feat:`** New features, including performance improvements *(will be added to Changelog)*
- **`fix:`** Bug fixes *(will be added to Changelog)*
- **`docs:`** Documentation only changes
- **`chore:`** Build, CI/CD, settings, tools (non-code changes)
- **`refactor:`** Code improvements including tests & cleanup (no behavior change)

**Examples:**

```bash
✅ feat(auth): implement OAuth login system #123
✅ feat(api): optimize database query performance #456
✅ fix(payment): resolve gateway timeout issue #789
✅ docs(readme): update installation guide #321
✅ chore(ci): update Node.js version in GitHub Actions #654
✅ chore(deps): upgrade React to v18.2.0 #987
✅ refactor(utils): simplify date formatting functions #246
✅ refactor(tests): improve test coverage for auth module #135
```

**Common Mistakes:**

```bash
❌ feat(AUTH): implement login #123     (scope must be lowercase)
❌ feat(auth): implement login. #123    (no period at end)
❌ feat(auth): implement login          (missing issue number)
❌ feat(auth): #123                     (empty description)
❌ feat(auth): implement user authentication system with OAuth and JWT #123  (>100 chars)
❌ style(auth): fix indentation #123    (use 'refactor:' instead)
❌ build(deps): update package #123     (use 'chore:' instead)
```

**Key Rules:**

- Header ≤100 characters
- Lowercase scope
- No period at end
- Must include issue number
- Use only approved commit types: `feat`, `fix`, `docs`, `chore`, `refactor`

### Commit Type Selection Guide

**Use `feat:` for:**

- New features and functionality
- Performance improvements
- API enhancements
- User-facing improvements

**Use `fix:` for:**

- Bug fixes
- Security patches
- Regression fixes
- Error handling improvements

**Use `docs:` for:**

- README updates
- Code comments
- Documentation files
- API documentation

**Use `chore:` for:**

- Dependency updates
- Build configuration
- CI/CD pipeline changes
- Development tools setup
- Package.json modifications

**Use `refactor:` for:**

- Code restructuring
- Test improvements
- Code cleanup
- Performance optimizations without new features
- Removing dead code

### Code Standards

- **Files:** Keep under 200 lines when possible
- **Functions >10 lines:** Add documentation comments
- **Imports:** Organize by standard → third-party → internal → relative
- **AI-Friendly Structure:** Add TOC/Overview at the top of every file (see below)

#### File Structure for AI Efficiency

**MANDATORY:** Every code file and test file and documents like *.md must include a TOC or Overview at the top in comments. This helps AI assistants understand file structure within the first 50-100 lines.

**JavaScript/TypeScript Example:**

```javascript
// ===============================================
// Module: payment-processor.js
// Description: Handles payment validation, processing, and webhooks
//
// Sections:
//   - Constants and Config
//   - Validation Functions
//   - Payment Processing Class
//   - Webhook Handlers
//   - Error Handling
//   - Exports
// ===============================================

import stripe from 'stripe';
// ... rest of imports

/**
 * Calculates cart total with discount and tax.
 * @param {Array} items - Cart items with price/quantity
 * @param {number} discountRate - Decimal rate (0.10 = 10%)
 * @returns {number} Final total price
 */
function calculateCartTotal(items, discountRate) {
  // implementation
}
```

**Test File Example:**

```javascript
// ===============================================
// Test Suite: payment-processor.test.js
// Description: Unit tests for payment processing functionality
//
// Test Groups:
//   - Setup and Teardown
//   - Validation Tests
//   - Payment Processing Tests
//   - Webhook Handler Tests
//   - Error Handling Tests
// ===============================================

import { describe, test, expect } from '@jest/globals';
// ... rest of test code
```

**Why This Helps AI:**

- Recognizes file structure immediately
- Skips irrelevant sections when unnecessary
- Predicts function names and responsibilities better
- Reduces token usage by understanding context faster

---

## 🔀 Step 3: Submit & Review

### Clean Commit History (MANDATORY)

Transform messy development commits into meaningful commits before creating PR.

**Small issues:** Usually 1 commit
**Larger issues:** Multiple logical commits (e.g., feat + docs + chore)

### Interactive Rebase Process

You can automate this using the scripts/squash_commits.sh script:

```bash
./scripts/squash_commits.sh
```

This script rebases your branch onto main, helps you squash commits interactively, edits the final message, and safely force-pushes the result.

### Create PR for Review

#### PR Body Creation Process

1. **Prepare the template content**: Copy the template from `.github/PULL_REQUEST_TEMPLATE.md`
2. **Create temporary file**: Create `.PR_BODY.md` in your project root using your code editor
3. **Fill out all sections**: Complete the template based on your changes (see example below)
4. **Create the PR**: Use the body file when creating your PR
5. **Clean up**: Delete the temporary file after successful PR creation

**Important:** Use your code editor to create `.PR_BODY.md` rather than terminal commands to avoid issues with long content.

#### Create PR

```bash
# Get the exact issue title for consistency
./scripts/get_issue_title.sh <issue-number>

# Create the PR using the body file, add --push to eliminates the interactive prompt.
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body-file .PR_BODY.md \
  --base main
  --push

# Clean up the temporary file after successful PR creation
rm .PR_BODY.md
```

#### Pre-submission Checklist

- [ ] Commits cleaned up with issue numbers
- [ ] All tests pass locally
- [ ] Build succeeds
- [ ] Code formatted (linting/prettier)
- [ ] Functions >10 lines documented
- [ ] **All files include TOC/Overview at the top for AI efficiency**
- [ ] **Commit types follow approved format** (`feat`, `fix`, `docs`, `chore`, `refactor`)

### Review Process

1. CODEOWNERS automatically assigned as reviewers
2. Address feedback promptly
3. All CI checks must pass
4. At least one approval required

### Merge Process

- **Only "Rebase and merge" allowed**
- **Maintainer performs merge** after approval
- **Branch auto-deleted** after merge
- **Commits appear on main exactly as they exist on feature branch**

---

## 📝 PR Guidelines

### PR Title Format

**Must match:** `<issue-title> #<issue-number>`

Get the exact title: `./scripts/get_issue_title.sh <issue-number>`

### PR Body Template

Use the template at `.github/PULL_REQUEST_TEMPLATE.md`:

- **Checklist** → Quality checks completed
- **Testing** → How changes were tested
- **Deployment Notes** → Special deployment needs
- **AI Assistance** → Transparency about AI use
- **Reviewer Notes** → Areas needing attention

### Template Completion

- Be honest about checklist items - don't check items that weren't done
- Provide specific details in optional sections when relevant
- Use the AI Assistance section to maintain transparency
- Give reviewers context in the Reviewer Notes section

#### Example

**Issue title:**

```bash
"docs: create AI pull request assistant guide #43"
```

**First commit message (matches PR title):**

```bash
"docs: create AI pull request assistant guide #43"
```

**PR body:**

```bash
## Checklist
- [x] My code follows the project's coding standards
- [x] I have performed a self-review of my code
- [x] I have commented my code, particularly in hard-to-understand areas
- [x] I have made corresponding changes to the documentation
- [x] My changes generate no new warnings
- [ ] I have added tests that prove my fix is effective or that my feature works
- [x] New and existing unit tests pass locally with my changes
- [x] Any dependent changes have been merged and published

## Testing
- [x] Existing tests pass
- [ ] Added new tests for new functionality (N/A for documentation)
- [x] Manual testing performed (verified document format and completeness)
- [ ] Tested on multiple browsers/environments (N/A for documentation)

### Test Evidence (Optional)
- Verified markdown formatting renders correctly
- Confirmed all referenced files exist and are accessible

## Deployment Notes (Optional)
- [x] No special deployment steps required
- [ ] Database migrations required
- [ ] Environment variables need to be updated
- [ ] Other: _________

## 🤖 AI Assistance (Optional)
- [x] This PR contains code generated or significantly assisted by AI.
- [x] I have reviewed the AI-generated code for accuracy, security, and quality.

**Prompt Used:** "Create documentation for AI agents to create pull requests following our issue-driven development process"

## Reviewer Notes (Optional)
- Please verify the PR creation workflow instructions are accurate for our setup
- Ensure the template completion examples align with project standards
```

---

## 🆘 Getting Help

### When to Ask

**ALWAYS ask when you:**

- Don't understand issue requirements
- Are unsure about technical approach
- Encounter unfamiliar technologies
- Are blocked and can't resolve alone
- Need clarification on project conventions

### How to Ask

1. **Comment in the issue** with specific questions
2. **Tag relevant team members** or use `@team`
3. **Provide context** about what you've tried
4. **Be specific** about what you need

### Example Help Request

```markdown
## Need Help 🆘

Stuck on payment integration webhook verification.

**What I've tried:**
- Read Stripe webhook docs
- Looked at existing handlers
- Attempted signature verification

**Questions:**
- How to store webhook secrets securely?
- Should processing be sync or queued?
- Existing utilities I should use?

Context: Issue #142 - Payment gateway integration
```

---

## ❓ FAQ

**Q: My commit fails validation. What should I check?**
A: Common issues - header >100 chars, uppercase scope, missing issue number, ends with period, invalid commit type. Use `git commit --amend` to fix.

**Q: When should I use `refactor:` vs `feat:`?**
A: Use `refactor:` for code improvements without behavior change (cleanup, optimization). Use `feat:` for new functionality or user-facing improvements.

**Q: What's the difference between `chore:` and `refactor:`?**
A: `chore:` is for non-code changes (build, CI, dependencies). `refactor:` is for code improvements without behavior change.

**Q: When do I clean commits?**
A: Before creating your PR. This is mandatory - reviewers expect clean history.

**Q: Do all commits need issue numbers?**
A: Yes, mandatory for traceability (except `chore(main):` commits).

**Q: How many commits per issue?**
A: Small issues = 1 commit, larger issues = multiple logical commits (feat + docs + chore, etc.).

**Q: Why do we need TOC/Overview at the top of files?**
A: AI assistants (like Copilot) typically read the first 50-100 lines to understand file context. A clear TOC helps them work more efficiently and provide better suggestions.

**Q: What should be included in the file TOC?**
A: Module name, brief description, and main sections/components. Keep it concise but informative - aim for 5-10 lines maximum.

---

## 🚨 Common Pitfalls

- **Never** skip writing tests first
- **Never** submit PRs without cleaning commit history
- **Never** commit without issue numbers (except `chore(main):`)
- **Never** use uppercase scopes in commits
- **Never** exceed 100 characters in commit headers
- **Never** end commit headers with periods
- **Never** submit PRs with failing tests
- **Never** forget to add TOC/Overview at the top of new files
- **Never** use commit types other than: `feat`, `fix`, `docs`, `chore`, `refactor`

---

## 📚 Reference Documents

- **README.md** → Project overview and tech stack
- **AGENTS.md** → AI assistant instructions
- **docs/AI_ISSUE_ASSISTANT.md** → Issue creation guidance
- **docs/AI_PULL_REQUEST_ASSISTANT.md** → PR creation guidance

---

**Success Criteria:** Following this guide results in tested, documented features with clean Git history that provides complete traceability and passes all validation checks.
