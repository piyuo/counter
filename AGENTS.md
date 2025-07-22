# AI Agent Instructions for Development

<!--
===============================================
Document: AGENTS.md
Purpose: Guide AI assistants on helping human developers with issue resolution and pull request creation

Overview:
  - Critical Documents & Requirements
  - Main Workflows (4 types)
  - Enhanced Decision Tree
  - Non-Negotiable Requirements
  - Troubleshooting Common Issues
  - Architecture Notes

Key Workflows:
  1. Resolve Issue → Complete issue resolution from start to finish
  2. Create Pull Request → When development is complete and ready for review
  3. Development Flow → Ongoing development work and code improvements
  4. Translation/Localization → i18n operations and quality review

Critical Dependencies:
  - CONTRIBUTING.md → Complete workflow, commit formats, testing requirements
  - README.md → Tech stack, implementation constraints, project setup
===============================================
-->

**Purpose:** This document guides AI assistants on how to help human developers with issue resolution and pull request creation.

Since AI assistants tend to focus on the section that seems most relevant and skip the broader context, we need to embed the critical reminders directly into each workflow section.

## 📋 Table of Contents & Quick Navigation

 📖 **Critical**

Always confirm understanding with the user before proceeding. If any required information is missing, proactively prompt the user to provide it.

### 🎯 **Overview**

- **Primary Use Cases:** Resolve GitHub issues, create pull requests, and ongoing development
- **Key Requirements:** Always read CONTRIBUTING.md + README.md for context
- **Success Criteria:** Clean, tested, documented code with TOC, proper commit messages, and full traceability.

### 📖 **Critical Documents (MUST READ EVERY TIME)**

- **CONTRIBUTING.md** → Complete workflow, commit formats, testing requirements
- **README.md** → Tech stack, implementation constraints, project setup
- **Templates** → PR body template and commit message formats

### 🔧 **Main Workflows**

1. **[Resolve Issue](/docs/AGENTS_RESOLVE_ISSUE.md)** → When asked "resolve issue #42"
   - Setup branch → Test-first development → Complete development → Create PR
2. **[Create Pull Request](/docs/AGENTS_CREATE_PULL_REQUEST.md)** → When development is complete and ready for review
   - Verify readiness → Clean history → Create PR
3. **[Development Flow](/docs/AGENTS_DEVELOPMENT.md)** → When working on existing issue/feature
   - Continue development → Apply best practices → Quality checkpoints → Iterative improvement
4. **[Translation/Localization/i18n](/docs/AGENTS_TRANSLATION_LOCALIZATION.md)** → When asked for translation help
   - Language detection → Translation operations → Quality review → Build procedures

### ⚡ **Enhanced Decision Tree**

- Human says "resolve issue #42" → Use Workflow 1
- Human says "create PR" AND development is complete → Use Workflow 2
- Human asks for development help, code improvements, or feature implementation → Use Workflow 3
- Human asks for translation help ("add translation", "delete key", "localize text") → Use Workflow 4
- Tests failing → See [Troubleshooting](#troubleshooting)
- Merge conflicts → See [Troubleshooting](#troubleshooting)
- Unsure what to do? → Read CONTRIBUTING.md first

### 🚨 **Non-Negotiable Requirements**

- Test-first development (≥80% coverage)
- Clean Git history before PR submission
- Issue numbers in all commits
- TOC at the top of all code files (Why TOC? AI assistants like Copilot read the first 50–100 lines to understand structure. A good TOC helps them provide smarter suggestions and navigate the file effectively.)

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
