# AI Agent Instructions for Development

**Purpose:** This document guides AI assistants on how to help human developers with issue resolution and pull request creation.

Since AI assistants tend to focus on the section that seems most relevant and skip the broader context, we need to embed the critical reminders directly into each workflow section.

## 📋 Table of Contents & Quick Navigation

 📖 **Critical**

Always confirm understanding with the user before proceeding. If any required information is missing, proactively prompt the user to provide it.

### 🎯 **Overview**

- **Primary Use Cases:** Resolve GitHub issues, create pull requests, and ongoing development
- **Key Requirements:** Always read CONTRIBUTING.md + README.md for context
- **Success Criteria:** Clean, tested, documented code with TOC, proper commit messages, and full traceability.

### 🔧 **Main Workflows**

1. **[Resolve Issue](#workflow-1-resolve-issue)** → When asked "resolve issue #42"
   - Setup branch → Test-first development → Complete development → Create PR
2. **[Create Pull Request](#workflow-2-create-pull-request)** → When development is complete and ready for review
   - Verify readiness → Clean history → Create PR
3. **[Development Flow](#workflow-3-development-flow)** → When working on existing issue/feature
   - Continue development → Apply best practices → Quality checkpoints → Iterative improvement

### 📖 **Critical Documents (MUST READ EVERY TIME)**

- **CONTRIBUTING.md** → Complete workflow, commit formats, testing requirements
- **README.md** → Tech stack, implementation constraints, project setup
- **Templates** → PR body template and commit message formats

### ⚡ **Enhanced Decision Tree**

- Human says "resolve issue #42" → Use Workflow 1
- Human says "create PR" AND development is complete → Use Workflow 2
- Human asks for development help, code improvements, or feature implementation → Use Workflow 3
- Tests failing → See [Troubleshooting](#troubleshooting)
- Merge conflicts → See [Troubleshooting](#troubleshooting)
- Unsure what to do? → Read CONTRIBUTING.md first

### 🚨 **Non-Negotiable Requirements**

- Test-first development (≥80% coverage)
- Clean Git history before PR submission
- Issue numbers in all commits
- TOC at the top of all code files (Why TOC? AI assistants like Copilot read the first 50–100 lines to understand structure. A good TOC helps them provide smarter suggestions and navigate the file effectively.)

---

## 🔧 Workflow 1: Resolve Issue

**Trigger:** Human says "resolve issue #42" or "solve issue #42"
**Prerequisites:** None - this workflow handles complete issue resolution from start to finish

**🚨 CRITICAL: Before starting, read CONTRIBUTING.md for complete workflow details and README.md for project-specific tech stack and implementation constraints.**

### Step 1: Setup Branch

```bash
./scripts/start-issue.sh <issue-number>
```

This creates the proper branch and assigns the issue.

**📖 Refer to CONTRIBUTING.md Step 1 for detailed branch creation instructions.**

### Step 2: Test-First Development

1. **Write tests first** (mandatory - ≥80% coverage)
2. **Develop solution** to make tests pass
3. **Iterate** until feature is complete

**📖 MANDATORY: Read CONTRIBUTING.md Step 2 for test-first development requirements and README.md for project-specific implementation guidance.**

### Step 3: Complete Development

**🎯 For ongoing development work, use [Workflow 3: Development Flow](#workflow-3-development-flow) patterns**

Continue development until the issue is fully resolved:

```bash
# Commit freely during development - these will be cleaned up later
git commit -m "add user authentication tests"
git commit -m "implement login validation"
git commit -m "fix edge case for empty passwords"
git commit -m "add integration tests for auth flow"
git commit -m "refactor validation logic"
```

### Step 4: Create PR for Review

**📖 CRITICAL: Follow CONTRIBUTING.md Step 3 for exact process requirements.**


**4a. Create PR:**

**Prepare PR body:**

- Copy the template from `.github/PULL_REQUEST_TEMPLATE.md`
- Create `.PR_BODY.md` in the project root using your code editor
- Fill out all sections completely

**Create the PR:**

```bash
# Get the exact issue title for consistency
./scripts/get-issue-title.sh <issue-number>

# Create PR, add --push to eliminates the interactive prompt.
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body-file .PR_BODY.md \
  --base main
  --push

# Clean up the temporary file
rm .PR_BODY.md
```

**4b. Verification Checklist:**

- [ ] All tests pass
- [ ] Build succeeds
- [ ] Code follows standards (TOC at the top of files, functions >10 lines documented)
- [ ] Clean commit history with proper format
- [ ] PR template fully completed
- [ ] PR title matches issue title exactly + `#<issue-number>`

### Step 5: Clean Up

Your work is done. Ensure all temporary files are removed.

---

## 📝 Workflow 2: Create Pull Request

**Trigger:** Human says "create a PR for issue #42" or "create a PR"
**Prerequisites:** Development work is complete, code is ready for review, commits already exist

**🚨 CRITICAL: This workflow assumes your feature/fix is already implemented and tested with existing commits. If you need to start development, use Workflow 1 instead.**

**🚨 Before starting, read CONTRIBUTING.md for the complete PR creation workflow and README.md for the project overview.**

### Step 1: Identify Issue Number

- If not provided, extract from the branch name (e.g., `45-feature-name` → issue #45)
- Verify the issue exists: `gh issue view <issue-number>`

**📖 Refer to CONTRIBUTING.md for branch naming conventions.**

### Step 2: Verify Readiness

- [ ] All tests pass
- [ ] Build succeeds
- [ ] Code follows standards (TOC at the top of files, functions >10 lines documented)
- [ ] At least one commit exists (required for PR creation)

**📖 MANDATORY: Check CONTRIBUTING.md for the complete pre-submission checklist and README.md for build requirements.**

### Step 3: Create PR for Review

**📖 CRITICAL: Follow CONTRIBUTING.md Step 3 for exact process requirements.**

**3a. Clean Up Git History:**

```bash
./scripts/squash-commits.sh
```

**3b. Create PR:**

**Prepare PR body:**

- Copy the template from `.github/PULL_REQUEST_TEMPLATE.md`
- Create `.PR_BODY.md` in the project root using your code editor
- Fill out all sections completely

**Create the PR:**

```bash
# Get the exact issue title for consistency
./scripts/get-issue-title.sh <issue-number>

# Create PR, add --push to eliminates the interactive prompt.
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body-file .PR_BODY.md \
  --base main
  --push

# Clean up the temporary file
rm .PR_BODY.md
```

**3c. Verification Checklist:**

- [ ] Clean commit history with proper format
- [ ] PR template fully completed
- [ ] Correct title format: `<issue-title> #<issue-number>`

### Step 4: Clean Up

Your work is done.


---

## 🔧 Workflow 3: Development Flow

**Trigger:** Human asks for development help, code improvements, feature implementation, or ongoing work on existing issue/branch
**Prerequisites:** Working on existing issue/feature (may or may not have existing commits)

**🚨 CRITICAL: Before starting, read CONTRIBUTING.md for development guidelines and README.md for project-specific tech stack and implementation constraints.**

### Step 1: Context Assessment

**Understand Current State:**

- [ ] Which issue/feature are we working on?
- [ ] What branch are we on? (`git branch --show-current`)
- [ ] What commits already exist? (`git log --oneline`)
- [ ] What's the current test status? (Run test suite)

**📖 Essential References (Read These):**

- **README.md** → Tech stack, implementation patterns, project-specific constraints
- **CONTRIBUTING.md** → Development guidelines, coding standards, testing requirements

### Step 2: Apply Test-Driven Development

**🚨 MANDATORY: Follow test-first approach for all development**

```bash
# Add tests for new functionality first
git commit -m "test: add validation tests for edge cases #<issue-number>"

# Implement the functionality to make tests pass
git commit -m "feat: implement password strength validation #<issue-number>"

# Refactor and improve
git commit -m "refactor: extract validation logic to utility #<issue-number>"
```

**Test-First Benefits:**

- Clarifies requirements before implementation
- Ensures comprehensive test coverage (≥80%)
- Enables confident refactoring
- Documents expected behavior

### Step 3: Apply Programming Best Practices

**🔧 Development Approach:**

**3a. Architecture & Design:**

- Choose appropriate design patterns for the problem
- Follow existing codebase patterns and conventions
- Consider separation of concerns and modularity
- Plan for extensibility and maintainability

**3b. Implementation Excellence:**

- **Performance:** Consider efficiency and scalability implications
- **Security:** Follow security best practices for the tech stack
- **Error Handling:** Implement comprehensive error handling and edge cases
- **Code Quality:** Write clean, readable, and maintainable code

**3c. Documentation Standards:**

- Add TOC at the top of new/modified files
- Document functions >10 lines with clear comments
- Explain complex logic and business rules
- Update relevant documentation files

### Step 4: Iterative Development Process

**4a. Problem-Solving Approach:**

1. **Break down complex problems** into smaller, manageable pieces
2. **Research solutions** using documentation, existing codebase patterns
3. **Experiment and validate** your approach with tests
4. **Refactor and optimize** as you learn more about the problem
5. **Document your decisions** in commit messages and code comments

**4b. Commit Strategy During Development:**

```bash
# Commit frequently with descriptive messages - these will be cleaned up later
git commit -m "WIP: initial OAuth integration setup #<issue-number>"
git commit -m "fix: handle expired token edge case #<issue-number>"
git commit -m "add: comprehensive input validation #<issue-number>"
git commit -m "debug: add logging for authentication flow #<issue-number>"
git commit -m "test: add integration tests for login workflow #<issue-number>"
git commit -m "docs: update API documentation #<issue-number>"
```

**4c. Continuous Quality Checks:**

- [ ] All existing tests still pass
- [ ] New functionality is thoroughly tested (≥80% coverage)
- [ ] Code follows project conventions and standards
- [ ] Edge cases and error conditions are handled
- [ ] Performance implications considered
- [ ] Security vulnerabilities addressed

### Step 5: Collaboration & Documentation

**5a. Progress Documentation:**

- Document design decisions and rationale in commit messages
- Note challenges encountered and solutions implemented
- Ask questions for areas needing clarification in GitHub discussions or issues
- Highlight areas that need additional attention

**5b. Code Review Preparation:**

- Ensure code is self-documenting with clear variable/function names
- Add comments for complex business logic
- Verify all edge cases are tested
- Check that error messages are user-friendly

### Step 6: Quality Validation

**Final Checks Before Completion:**

- [ ] Issue #<number> requirements fully implemented
- [ ] All tests pass (both new and existing)
- [ ] Code quality meets project standards
- [ ] No breaking changes introduced
- [ ] Performance is acceptable
- [ ] Security considerations addressed
- [ ] Documentation is complete and accurate
- [ ] Ready for peer review

**✅ Completion Criteria:**
Your development work is complete when all requirements are implemented, thoroughly tested, and the code meets quality standards.

**🎯 Next Steps:**

- If working within Workflow 1: Return to Step 4 (Create PR)
- If working independently: Consider creating a PR using Workflow 2
- If more development needed: Continue iterating through this workflow

**📝 Remember:** You are an experienced developer - trust your judgment on technical decisions while staying aligned with project patterns and standards. When in doubt, refer to existing codebase examples or ask questions in GitHub discussions.

---

## 🔧 Troubleshooting Common Issues

### Issue Doesn't Exist

**Problem:** `gh issue view <number>` fails
**Solution:**

- Verify the issue number with the human
- Ask the human to create the issue first if missing
- Check if the issue is in a different repository

### Branch Already Exists

**Problem:** Branch name conflict
**Solution:**

```bash
# Check existing branches
git branch -a | grep <issue-number>

# If you're already working on it
git checkout <branch-name>
git pull origin <branch-name>

```

### Cannot Create PR - No Commits

**Problem:** `gh pr create` fails with "no commits between branches"
**Solution:**

1. Verify you have commits: `git log --oneline`
2. If no commits, you need to complete development first
3. Make sure you're on the correct branch
4. Use Workflow 1 if starting from scratch

### Tests Failing

**Problem:** Test suite doesn't pass
**Solution:**

1. Run tests locally: See README.md for the "Run all tests" command
2. Fix failing tests before proceeding
3. Refer to CONTRIBUTING.md for test requirements
4. Ask for help if blocked on test failures

### Merge Conflicts

**Problem:** Conflicts during rebase
**Solution:**

1. Resolve conflicts in the affected files
2. Stage resolved files: `git add <file>`
3. Continue rebase: `git rebase --continue`
4. If stuck, abort and ask for help: `git rebase --abort`

---

## 📋 Architecture Notes

### Layout Architecture (Fixed: Dec 2024)

**Issue Fixed:** Runtime error "Missing <html> and <body> tags in the root layout" when browsing non-existent routes.

**Root Cause:** The root layout (`app/layout.tsx`) was only returning `children` without the required HTML structure. When Next.js couldn't find a specific route and fell back to the root layout, it lacked the mandatory `<html>` and `<body>` tags.

**Solution Implemented:**

1. **Updated Root Layout:** Modified `app/layout.tsx` to include proper HTML structure:
   ```tsx
   return (
     <html lang="en">
       <body className="antialiased">
         {children}
       </body>
     </html>
   );
   ```

2. **Added Global 404 Page:** Created `app/not-found.tsx` to handle non-existent routes gracefully with a user-friendly interface.

3. **Architecture Pattern:**
   - **Root layout:** Provides HTML structure for fallback cases (404, errors)
   - **Locale layouts:** Handle main application routes with proper locale-specific HTML attributes
   - **No conflicts:** Both can coexist as they serve different purposes

**Testing:** All existing tests updated and new tests added to ensure the fix works correctly while maintaining the existing functionality.

---

# AI Agent Instructions for Development

**Purpose:** This document guides AI assistants on how to help human developers with issue resolution and pull request creation.

Since AI assistants tend to focus on the section that seems most relevant and skip the broader context, we need to embed the critical reminders directly into each workflow section.

## 📋 Table of Contents & Quick Navigation

 📖 **Critical**

Always confirm understanding with the user before proceeding. If any required information is missing, proactively prompt the user to provide it.

### 🎯 **Overview**

- **Primary Use Cases:** Resolve GitHub issues, create pull requests, and ongoing development
- **Key Requirements:** Always read CONTRIBUTING.md + README.md for context
- **Success Criteria:** Clean, tested, documented code with TOC, proper commit messages, and full traceability.

### 🔧 **Main Workflows**

1. **[Resolve Issue](#workflow-1-resolve-issue)** → When asked "resolve issue #42"
   - Setup branch → Test-first development → Complete development → Create PR
2. **[Create Pull Request](#workflow-2-create-pull-request)** → When development is complete and ready for review
   - Verify readiness → Clean history → Create PR
3. **[Development Flow](#workflow-3-development-flow)** → When working on existing issue/feature
   - Continue development → Apply best practices → Quality checkpoints → Iterative improvement

### 📖 **Critical Documents (MUST READ EVERY TIME)**

- **CONTRIBUTING.md** → Complete workflow, commit formats, testing requirements
- **README.md** → Tech stack, implementation constraints, project setup
- **Templates** → PR body template and commit message formats

### ⚡ **Enhanced Decision Tree**

- Human says "resolve issue #42" → Use Workflow 1
- Human says "create PR" AND development is complete → Use Workflow 2
- Human asks for development help, code improvements, or feature implementation → Use Workflow 3
- Tests failing → See [Troubleshooting](#troubleshooting)
- Merge conflicts → See [Troubleshooting](#troubleshooting)
- Unsure what to do? → Read CONTRIBUTING.md first

### 🚨 **Non-Negotiable Requirements**

- Test-first development (≥80% coverage)
- Clean Git history before PR submission
- Issue numbers in all commits
- TOC at the top of all code files (Why TOC? AI assistants like Copilot read the first 50–100 lines to understand structure. A good TOC helps them provide smarter suggestions and navigate the file effectively.)

---

## 🔧 Workflow 1: Resolve Issue

**Trigger:** Human says "resolve issue #42" or "solve issue #42"
**Prerequisites:** None - this workflow handles complete issue resolution from start to finish

**🚨 CRITICAL: Before starting, read CONTRIBUTING.md for complete workflow details and README.md for project-specific tech stack and implementation constraints.**

### Step 1: Setup Branch

```bash
./scripts/start-issue.sh <issue-number>
```

This creates the proper branch and assigns the issue.

**📖 Refer to CONTRIBUTING.md Step 1 for detailed branch creation instructions.**

### Step 2: Test-First Development

1. **Write tests first** (mandatory - ≥80% coverage)
2. **Develop solution** to make tests pass
3. **Iterate** until feature is complete

**📖 MANDATORY: Read CONTRIBUTING.md Step 2 for test-first development requirements and README.md for project-specific implementation guidance.**

### Step 3: Complete Development

**🎯 For ongoing development work, use [Workflow 3: Development Flow](#workflow-3-development-flow) patterns**

Continue development until the issue is fully resolved:

```bash
# Commit freely during development - these will be cleaned up later
git commit -m "add user authentication tests"
git commit -m "implement login validation"
git commit -m "fix edge case for empty passwords"
git commit -m "add integration tests for auth flow"
git commit -m "refactor validation logic"
```

### Step 4: Create PR for Review

**📖 CRITICAL: Follow CONTRIBUTING.md Step 3 for exact process requirements.**


**4a. Create PR:**

**Prepare PR body:**

- Copy the template from `.github/PULL_REQUEST_TEMPLATE.md`
- Create `.PR_BODY.md` in the project root using your code editor
- Fill out all sections completely

**Create the PR:**

```bash
# Get the exact issue title for consistency
./scripts/get-issue-title.sh <issue-number>

# Create PR, add --push to eliminates the interactive prompt.
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body-file .PR_BODY.md \
  --base main
  --push

# Clean up the temporary file
rm .PR_BODY.md
```

**4b. Verification Checklist:**

- [ ] All tests pass
- [ ] Build succeeds
- [ ] Code follows standards (TOC at the top of files, functions >10 lines documented)
- [ ] Clean commit history with proper format
- [ ] PR template fully completed
- [ ] PR title matches issue title exactly + `#<issue-number>`

### Step 5: Clean Up

Your work is done. Ensure all temporary files are removed.

---

## 📝 Workflow 2: Create Pull Request

**Trigger:** Human says "create a PR for issue #42" or "create a PR"
**Prerequisites:** Development work is complete, code is ready for review, commits already exist

**🚨 CRITICAL: This workflow assumes your feature/fix is already implemented and tested with existing commits. If you need to start development, use Workflow 1 instead.**

**🚨 Before starting, read CONTRIBUTING.md for the complete PR creation workflow and README.md for the project overview.**

### Step 1: Identify Issue Number

- If not provided, extract from the branch name (e.g., `45-feature-name` → issue #45)
- Verify the issue exists: `gh issue view <issue-number>`

**📖 Refer to CONTRIBUTING.md for branch naming conventions.**

### Step 2: Verify Readiness

- [ ] All tests pass
- [ ] Build succeeds
- [ ] Code follows standards (TOC at the top of files, functions >10 lines documented)
- [ ] At least one commit exists (required for PR creation)

**📖 MANDATORY: Check CONTRIBUTING.md for the complete pre-submission checklist and README.md for build requirements.**

### Step 3: Create PR for Review

**📖 CRITICAL: Follow CONTRIBUTING.md Step 3 for exact process requirements.**

**3a. Clean Up Git History:**

```bash
./scripts/squash-commits.sh
```

**3b. Create PR:**

**Prepare PR body:**

- Copy the template from `.github/PULL_REQUEST_TEMPLATE.md`
- Create `.PR_BODY.md` in the project root using your code editor
- Fill out all sections completely

**Create the PR:**

```bash
# Get the exact issue title for consistency
./scripts/get-issue-title.sh <issue-number>

# Create PR, add --push to eliminates the interactive prompt.
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body-file .PR_BODY.md \
  --base main
  --push

# Clean up the temporary file
rm .PR_BODY.md
```

**3c. Verification Checklist:**

- [ ] Clean commit history with proper format
- [ ] PR template fully completed
- [ ] Correct title format: `<issue-title> #<issue-number>`

### Step 4: Clean Up

Your work is done.


---

## 🔧 Workflow 3: Development Flow

**Trigger:** Human asks for development help, code improvements, feature implementation, or ongoing work on existing issue/branch
**Prerequisites:** Working on existing issue/feature (may or may not have existing commits)

**🚨 CRITICAL: Before starting, read CONTRIBUTING.md for development guidelines and README.md for project-specific tech stack and implementation constraints.**

### Step 1: Context Assessment

**Understand Current State:**

- [ ] Which issue/feature are we working on?
- [ ] What branch are we on? (`git branch --show-current`)
- [ ] What commits already exist? (`git log --oneline`)
- [ ] What's the current test status? (Run test suite)

**📖 Essential References (Read These):**

- **README.md** → Tech stack, implementation patterns, project-specific constraints
- **CONTRIBUTING.md** → Development guidelines, coding standards, testing requirements

### Step 2: Apply Test-Driven Development

**🚨 MANDATORY: Follow test-first approach for all development**

```bash
# Add tests for new functionality first
git commit -m "test: add validation tests for edge cases #<issue-number>"

# Implement the functionality to make tests pass
git commit -m "feat: implement password strength validation #<issue-number>"

# Refactor and improve
git commit -m "refactor: extract validation logic to utility #<issue-number>"
```

**Test-First Benefits:**

- Clarifies requirements before implementation
- Ensures comprehensive test coverage (≥80%)
- Enables confident refactoring
- Documents expected behavior

### Step 3: Apply Programming Best Practices

**🔧 Development Approach:**

**3a. Architecture & Design:**

- Choose appropriate design patterns for the problem
- Follow existing codebase patterns and conventions
- Consider separation of concerns and modularity
- Plan for extensibility and maintainability

**3b. Implementation Excellence:**

- **Performance:** Consider efficiency and scalability implications
- **Security:** Follow security best practices for the tech stack
- **Error Handling:** Implement comprehensive error handling and edge cases
- **Code Quality:** Write clean, readable, and maintainable code

**3c. Documentation Standards:**

- Add TOC at the top of new/modified files
- Document functions >10 lines with clear comments
- Explain complex logic and business rules
- Update relevant documentation files

### Step 4: Iterative Development Process

**4a. Problem-Solving Approach:**

1. **Break down complex problems** into smaller, manageable pieces
2. **Research solutions** using documentation, existing codebase patterns
3. **Experiment and validate** your approach with tests
4. **Refactor and optimize** as you learn more about the problem
5. **Document your decisions** in commit messages and code comments

**4b. Commit Strategy During Development:**

```bash
# Commit frequently with descriptive messages - these will be cleaned up later
git commit -m "WIP: initial OAuth integration setup #<issue-number>"
git commit -m "fix: handle expired token edge case #<issue-number>"
git commit -m "add: comprehensive input validation #<issue-number>"
git commit -m "debug: add logging for authentication flow #<issue-number>"
git commit -m "test: add integration tests for login workflow #<issue-number>"
git commit -m "docs: update API documentation #<issue-number>"
```

**4c. Continuous Quality Checks:**

- [ ] All existing tests still pass
- [ ] New functionality is thoroughly tested (≥80% coverage)
- [ ] Code follows project conventions and standards
- [ ] Edge cases and error conditions are handled
- [ ] Performance implications considered
- [ ] Security vulnerabilities addressed

### Step 5: Collaboration & Documentation

**5a. Progress Documentation:**

- Document design decisions and rationale in commit messages
- Note challenges encountered and solutions implemented
- Ask questions for areas needing clarification in GitHub discussions or issues
- Highlight areas that need additional attention

**5b. Code Review Preparation:**

- Ensure code is self-documenting with clear variable/function names
- Add comments for complex business logic
- Verify all edge cases are tested
- Check that error messages are user-friendly

### Step 6: Quality Validation

**Final Checks Before Completion:**

- [ ] Issue #<number> requirements fully implemented
- [ ] All tests pass (both new and existing)
- [ ] Code quality meets project standards
- [ ] No breaking changes introduced
- [ ] Performance is acceptable
- [ ] Security considerations addressed
- [ ] Documentation is complete and accurate
- [ ] Ready for peer review

**✅ Completion Criteria:**
Your development work is complete when all requirements are implemented, thoroughly tested, and the code meets quality standards.

**🎯 Next Steps:**

- If working within Workflow 1: Return to Step 4 (Create PR)
- If working independently: Consider creating a PR using Workflow 2
- If more development needed: Continue iterating through this workflow

**📝 Remember:** You are an experienced developer - trust your judgment on technical decisions while staying aligned with project patterns and standards. When in doubt, refer to existing codebase examples or ask questions in GitHub discussions.

---

## 🔧 Troubleshooting Common Issues

### Issue Doesn't Exist

**Problem:** `gh issue view <number>` fails
**Solution:**

- Verify the issue number with the human
- Ask the human to create the issue first if missing
- Check if the issue is in a different repository

### Branch Already Exists

**Problem:** Branch name conflict
**Solution:**

```bash
# Check existing branches
git branch -a | grep <issue-number>

# If you're already working on it
git checkout <branch-name>
git pull origin <branch-name>

```

### Cannot Create PR - No Commits

**Problem:** `gh pr create` fails with "no commits between branches"
**Solution:**

1. Verify you have commits: `git log --oneline`
2. If no commits, you need to complete development first
3. Make sure you're on the correct branch
4. Use Workflow 1 if starting from scratch

### Tests Failing

**Problem:** Test suite doesn't pass
**Solution:**

1. Run tests locally: See README.md for the "Run all tests" command
2. Fix failing tests before proceeding
3. Refer to CONTRIBUTING.md for test requirements
4. Ask for help if blocked on test failures

### Merge Conflicts

**Problem:** Conflicts during rebase
**Solution:**

1. Resolve conflicts in the affected files
2. Stage resolved files: `git add <file>`
3. Continue rebase: `git rebase --continue`
4. If stuck, abort and ask for help: `git rebase --abort`

---

## 📋 Architecture Notes

### Layout Architecture (Fixed: Dec 2024)

**Issue Fixed:** Runtime error "Missing <html> and <body> tags in the root layout" when browsing non-existent routes.

**Root Cause:** The root layout (`app/layout.tsx`) was only returning `children` without the required HTML structure. When Next.js couldn't find a specific route and fell back to the root layout, it lacked the mandatory `<html>` and `<body>` tags.

**Solution Implemented:**

1. **Updated Root Layout:** Modified `app/layout.tsx` to include proper HTML structure:
   ```tsx
   return (
     <html lang="en">
       <body className="antialiased">
         {children}
       </body>
     </html>
   );
   ```

2. **Added Global 404 Page:** Created `app/not-found.tsx` to handle non-existent routes gracefully with a user-friendly interface.

3. **Architecture Pattern:**
   - **Root layout:** Provides HTML structure for fallback cases (404, errors)
   - **Locale layouts:** Handle main application routes with proper locale-specific HTML attributes
   - **No conflicts:** Both can coexist as they serve different purposes

**Testing:** All existing tests updated and new tests added to ensure the fix works correctly while maintaining the existing functionality.

---

# AI Agent Instructions for Development

**Purpose:** This document guides AI assistants on how to help human developers with issue resolution and pull request creation.

Since AI assistants tend to focus on the section that seems most relevant and skip the broader context, we need to embed the critical reminders directly into each workflow section.

## 📋 Table of Contents & Quick Navigation

 📖 **Critical**

Always confirm understanding with the user before proceeding. If any required information is missing, proactively prompt the user to provide it.

### 🎯 **Overview**

- **Primary Use Cases:** Resolve GitHub issues, create pull requests, and ongoing development
- **Key Requirements:** Always read CONTRIBUTING.md + README.md for context
- **Success Criteria:** Clean, tested, documented code with TOC, proper commit messages, and full traceability.

### 🔧 **Main Workflows**

1. **[Resolve Issue](#workflow-1-resolve-issue)** → When asked "resolve issue #42"
   - Setup branch → Test-first development → Complete development → Create PR
2. **[Create Pull Request](#workflow-2-create-pull-request)** → When development is complete and ready for review
   - Verify readiness → Clean history → Create PR
3. **[Development Flow](#workflow-3-development-flow)** → When working on existing issue/feature
   - Continue development → Apply best practices → Quality checkpoints → Iterative improvement

### 📖 **Critical Documents (MUST READ EVERY TIME)**

- **CONTRIBUTING.md** → Complete workflow, commit formats, testing requirements
- **README.md** → Tech stack, implementation constraints, project setup
- **Templates** → PR body template and commit message formats

### ⚡ **Enhanced Decision Tree**

- Human says "resolve issue #42" → Use Workflow 1
- Human says "create PR" AND development is complete → Use Workflow 2
- Human asks for development help, code improvements, or feature implementation → Use Workflow 3
- Tests failing → See [Troubleshooting](#troubleshooting)
- Merge conflicts → See [Troubleshooting](#troubleshooting)
- Unsure what to do? → Read CONTRIBUTING.md first

### 🚨 **Non-Negotiable Requirements**

- Test-first development (≥80% coverage)
- Clean Git history before PR submission
- Issue numbers in all commits
- TOC at the top of all code files (Why TOC? AI assistants like Copilot read the first 50–100 lines to understand structure. A good TOC helps them provide smarter suggestions and navigate the file effectively.)

---

## 🔧 Workflow 1: Resolve Issue

**Trigger:** Human says "resolve issue #42" or "solve issue #42"
**Prerequisites:** None - this workflow handles complete issue resolution from start to finish

**🚨 CRITICAL: Before starting, read CONTRIBUTING.md for complete workflow details and README.md for project-specific tech stack and implementation constraints.**

### Step 1: Setup Branch

```bash
./scripts/start-issue.sh <issue-number>
```

This creates the proper branch and assigns the issue.

**📖 Refer to CONTRIBUTING.md Step 1 for detailed branch creation instructions.**

### Step 2: Test-First Development

1. **Write tests first** (mandatory - ≥80% coverage)
2. **Develop solution** to make tests pass
3. **Iterate** until feature is complete

**📖 MANDATORY: Read CONTRIBUTING.md Step 2 for test-first development requirements and README.md for project-specific implementation guidance.**

### Step 3: Complete Development

**🎯 For ongoing development work, use [Workflow 3: Development Flow](#workflow-3-development-flow) patterns**

Continue development until the issue is fully resolved:

```bash
# Commit freely during development - these will be cleaned up later
git commit -m "add user authentication tests"
git commit -m "implement login validation"
git commit -m "fix edge case for empty passwords"
git commit -m "add integration tests for auth flow"
git commit -m "refactor validation logic"
```

### Step 4: Create PR for Review

**📖 CRITICAL: Follow CONTRIBUTING.md Step 3 for exact process requirements.**


**4a. Create PR:**

**Prepare PR body:**

- Copy the template from `.github/PULL_REQUEST_TEMPLATE.md`
- Create `.PR_BODY.md` in the project root using your code editor
- Fill out all sections completely

**Create the PR:**

```bash
# Get the exact issue title for consistency
./scripts/get-issue-title.sh <issue-number>

# Create PR, add --push to eliminates the interactive prompt.
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body-file .PR_BODY.md \
  --base main
  --push

# Clean up the temporary file
rm .PR_BODY.md
```

**4b. Verification Checklist:**

- [ ] All tests pass
- [ ] Build succeeds
- [ ] Code follows standards (TOC at the top of files, functions >10 lines documented)
- [ ] Clean commit history with proper format
- [ ] PR template fully completed
- [ ] PR title matches issue title exactly + `#<issue-number>`

### Step 5: Clean Up

Your work is done. Ensure all temporary files are removed.

---

## 📝 Workflow 2: Create Pull Request

**Trigger:** Human says "create a PR for issue #42" or "create a PR"
**Prerequisites:** Development work is complete, code is ready for review, commits already exist

**🚨 CRITICAL: This workflow assumes your feature/fix is already implemented and tested with existing commits. If you need to start development, use Workflow 1 instead.**

**🚨 Before starting, read CONTRIBUTING.md for the complete PR creation workflow and README.md for the project overview.**

### Step 1: Identify Issue Number

- If not provided, extract from the branch name (e.g., `45-feature-name` → issue #45)
- Verify the issue exists: `gh issue view <issue-number>`

**📖 Refer to CONTRIBUTING.md for branch naming conventions.**

### Step 2: Verify Readiness

- [ ] All tests pass
- [ ] Build succeeds
- [ ] Code follows standards (TOC at the top of files, functions >10 lines documented)
- [ ] At least one commit exists (required for PR creation)

**📖 MANDATORY: Check CONTRIBUTING.md for the complete pre-submission checklist and README.md for build requirements.**

### Step 3: Create PR for Review

**📖 CRITICAL: Follow CONTRIBUTING.md Step 3 for exact process requirements.**

**3a. Clean Up Git History:**

```bash
./scripts/squash-commits.sh
```

**3b. Create PR:**

**Prepare PR body:**

- Copy the template from `.github/PULL_REQUEST_TEMPLATE.md`
- Create `.PR_BODY.md` in the project root using your code editor
- Fill out all sections completely

**Create the PR:**

```bash
# Get the exact issue title for consistency
./scripts/get-issue-title.sh <issue-number>

# Create PR, add --push to eliminates the interactive prompt.
gh pr create \
  --title "<issue-title> #<issue-number>" \
  --body-file .PR_BODY.md \
  --base main
  --push

# Clean up the temporary file
rm .PR_BODY.md
```

**3c. Verification Checklist:**

- [ ] Clean commit history with proper format
- [ ] PR template fully completed
- [ ] Correct title format: `<issue-title> #<issue-number>`

### Step 4: Clean Up

Your work is done.


---

## 🔧 Workflow 3: Development Flow

**Trigger:** Human asks for development help, code improvements, feature implementation, or ongoing work on existing issue/branch
**Prerequisites:** Working on existing issue/feature (may or may not have existing commits)

**🚨 CRITICAL: Before starting, read CONTRIBUTING.md for development guidelines and README.md for project-specific tech stack and implementation constraints.**

### Step 1: Context Assessment

**Understand Current State:**

- [ ] Which issue/feature are we working on?
- [ ] What branch are we on? (`git branch --show-current`)
- [ ] What commits already exist? (`git log --oneline`)
- [ ] What's the current test status? (Run test suite)

**📖 Essential References (Read These):**

- **README.md** → Tech stack, implementation patterns, project-specific constraints
- **CONTRIBUTING.md** → Development guidelines, coding standards, testing requirements

### Step 2: Apply Test-Driven Development

**🚨 MANDATORY: Follow test-first approach for all development**

```bash
# Add tests for new functionality first
git commit -m "test: add validation tests for edge cases #<issue-number>"

# Implement the functionality to make tests pass
git commit -m "feat: implement password strength validation #<issue-number>"

# Refactor and improve
git commit -m "refactor: extract validation logic to utility #<issue-number>"
```

**Test-First Benefits:**

- Clarifies requirements before implementation
- Ensures comprehensive test coverage (≥80%)
- Enables confident refactoring
- Documents expected behavior

### Step 3: Apply Programming Best Practices

**🔧 Development Approach:**

**3a. Architecture & Design:**

- Choose appropriate design patterns for the problem
- Follow existing codebase patterns and conventions
- Consider separation of concerns and modularity
- Plan for extensibility and maintainability

**3b. Implementation Excellence:**

- **Performance:** Consider efficiency and scalability implications
- **Security:** Follow security best practices for the tech stack
- **Error Handling:** Implement comprehensive error handling and edge cases
- **Code Quality:** Write clean, readable, and maintainable code

**3c. Documentation Standards:**

- Add TOC at the top of new/modified files
- Document functions >10 lines with clear comments
- Explain complex logic and business rules
- Update relevant documentation files

### Step 4: Iterative Development Process

**4a. Problem-Solving Approach:**

1. **Break down complex problems** into smaller, manageable pieces
2. **Research solutions** using documentation, existing codebase patterns
3. **Experiment and validate** your approach with tests
4. **Refactor and optimize** as you learn more about the problem
5. **Document your decisions** in commit messages and code comments

**4b. Commit Strategy During Development:**

```bash
# Commit frequently with descriptive messages - these will be cleaned up later
git commit -m "WIP: initial OAuth integration setup #<issue-number>"
git commit -m "fix: handle expired token edge case #<issue-number>"
git commit -m "add: comprehensive input validation #<issue-number>"
git commit -m "debug: add logging for authentication flow #<issue-number>"
git commit -m "test: add integration tests for login workflow #<issue-number>"
git commit -m "docs: update API documentation #<issue-number>"
```

**4c. Continuous Quality Checks:**

- [ ] All existing tests still pass
- [ ] New functionality is thoroughly tested (≥80% coverage)
- [ ] Code follows project conventions and standards
- [ ] Edge cases and error conditions are handled
- [ ] Performance implications considered
- [ ] Security vulnerabilities addressed

### Step 5: Collaboration & Documentation

**5a. Progress Documentation:**

- Document design decisions and rationale in commit messages
- Note challenges encountered and solutions implemented
- Ask questions for areas needing clarification in GitHub discussions or issues
- Highlight areas that need additional attention

**5b. Code Review Preparation:**

- Ensure code is self-documenting with clear variable/function names
- Add comments for complex business logic
- Verify all edge cases are tested
- Check that error messages are user-friendly

### Step 6: Quality Validation

**Final Checks Before Completion:**

- [ ] Issue #<number> requirements fully implemented
- [ ] All tests pass (both new and existing)
- [ ] Code quality meets project standards
- [ ] No breaking changes introduced
- [ ] Performance is acceptable
- [ ] Security considerations addressed
- [ ] Documentation is complete and accurate
- [ ] Ready for peer review

**✅ Completion Criteria:**
Your development work is complete when all requirements are implemented, thoroughly tested, and the code meets quality standards.

**🎯 Next Steps:**

- If working within Workflow 1: Return to Step 4 (Create PR)
- If working independently: Consider creating a PR using Workflow 2
- If more development needed: Continue iterating through this workflow

**📝 Remember:** You are an experienced developer - trust your judgment on technical decisions while staying aligned with project patterns and standards. When in doubt, refer to existing codebase examples or ask questions in GitHub discussions.

---

## 🔧 Troubleshooting Common Issues

### Issue Doesn't Exist

**Problem:** `gh issue view <number>` fails
**Solution:**

- Verify the issue number with the human
- Ask the human to create the issue first if missing
- Check if the issue is in a different repository

### Branch Already Exists

**Problem:** Branch name conflict
**Solution:**

```bash
# Check existing branches
git branch -a | grep <issue-number>

# If you're already working on it
git checkout <branch-name>
git pull origin <branch-name>

```

### Cannot Create PR - No Commits

**Problem:** `gh pr create` fails with "no commits between branches"
**Solution:**

1. Verify you have commits: `git log --oneline`
2. If no commits, you need to complete development first
3. Make sure you're on the correct branch
4. Use Workflow 1 if starting from scratch

### Tests Failing

**Problem:** Test suite doesn't pass
**Solution:**

1. Run tests locally: See README.md for the "Run all tests" command
2. Fix failing tests before proceeding
3. Refer to CONTRIBUTING.md for test requirements
4. Ask for help if blocked on test failures

### Merge Conflicts

**Problem:** Conflicts during rebase
**Solution:**

1. Resolve conflicts in the affected files
2. Stage resolved files: `git add <file>`
3. Continue rebase: `git rebase --continue`
4. If stuck, abort and ask for help: `git rebase --abort`

---

## 📋 Architecture Notes

### Layout Architecture (Fixed: Dec 2024)

**Issue Fixed:** Runtime error "Missing <html> and <body> tags in the root layout" when browsing non-existent routes.

**Root Cause:** The root layout (`app/layout.tsx`) was only returning `children` without the required HTML structure. When Next.js couldn't find a specific route and fell back to the root layout, it lacked the mandatory `<html>` and `<body>` tags.

**Solution Implemented:**

1. **Updated Root Layout:** Modified `app/layout.tsx` to include proper HTML structure:
   ```tsx
   return (
     <html lang="en">
       <body className="antialiased">
         {children}
       </body>
     </html>
   );
   ```

2. **Added Global 404 Page:** Created `app/not-found.tsx` to handle non-existent routes gracefully with a user-friendly interface.

3. **Architecture Pattern:**
   - **Root layout:** Provides HTML structure for fallback cases (404, errors)
   - **Locale layouts:** Handle main application routes with proper locale-specific HTML attributes
   - **No conflicts:** Both can coexist as they serve different purposes

**Testing:** All existing tests updated and new tests added to ensure the fix works correctly while maintaining the existing functionality.

---
