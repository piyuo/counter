# Contributing Guidelines

We follow a structured Git workflow to ensure code quality and maintainability.

## 🌿 Branching Strategy

We follow the standard **Git Flow** methodology for branch management:

```
feature/bugfix → develop → release → main
                    ↑         ↓
               (integration)  (release prep)
```

### Main Branches
- **`main`** - Production branch
  - Contains only stable, released code
  - All releases are tagged here and deployed via CI/CD
  - Example: Version tags like `v1.2.0` are created on this branch

- **`develop`** - Integration branch
  - Contains the latest integrated features for the next release
  - May be unstable as new features are integrated
  - All feature and bugfix branches merge here first

### Supporting Branches
- **`feature/*`** - New feature development
  - **Branch from**: `develop`
  - **Merge back to**: `develop`
  - Example: `feature/add-login-window`

- **`bugfix/*`** - Bug fixes during development
  - **Branch from**: `develop`
  - **Merge back to**: `develop`
  - Example: `bugfix/fix-login-error`


- **`hotfix/*`** - Emergency production fixes
  - **Branch from**: `main`
  - **Merge to**: both `main` and `develop`
  - For critical bugs that need immediate production deployment
  - Example: `hotfix/patch-crash-on-launch`

## 🔄 Contribution Workflow

### 1. Create an Issue
All work must begin with a GitHub Issue to track the problem or feature request.

### 2. Create Your Branch
Create a branch from the appropriate source:

**For features and bug fixes:**
```bash
# Switch to develop branch
git checkout develop
git pull origin develop

# Create your feature branch
git checkout -b feature/your-feature-name
# or
git checkout -b bugfix/your-bug-fix
```

**GitHub Integration**: If you use GitHub's "Create a branch for this issue" feature, ensure the source branch is set to `develop` for features/bugfixes.

### 3. Branch Naming Convention
**Required**: Always use GitHub's "Create a branch for this issue" button to ensure consistent naming.

When creating a branch from an issue:
1. Navigate to the relevant GitHub Issue
2. Click "Create a branch for this issue" in the Development section
3. **Important**: Set the source branch to `develop` for features and bugfixes
4. GitHub will auto-generate a descriptive branch name like `3-add-login-page`

This approach ensures:
- Consistent naming across all contributors
- Automatic linking between branches and issues
- Clear traceability of work

### 4. Commit Message Guidelines
We follow the [Conventional Commits](https://www.conventionalcommits.org/) format:

| Type     | Description                       | Example                                    |
| -------- | --------------------------------- | ------------------------------------------ |
| `feat:`  | New feature                       | `feat: add support for new tracking model` |
| `fix:`   | Bug fix                           | `fix: correct frame buffer size on iOS`    |
| `docs:`  | Documentation changes             | `docs: update API documentation`           |
| `chore:` | Maintenance, refactor, formatting | `chore: update build script for CI`        |
| `test:`  | Adding or modifying tests         | `test: add unit tests for login module`    |

**Important principle**: Each commit should be scoped to a single purpose.

### 5. Pull Request Process
- **Target branch**:
  - Features/bugfixes: merge to `develop`
  - Hotfixes: merge to `main` (then merge `main` back to `develop`)
  - Release branches: merge to both `main` and `develop`
- **Link to Issue**: Reference the Issue number in the PR description using `Fixes #<number>` or `Closes #<number>`
- **Quality commits**: Write meaningful commit messages following our conventions
- **Pre-review checks**: Ensure all CI checks pass before requesting review

### 6. Changelog
Follow [Conventional Commits](https://www.conventionalcommits.org/) standards for commit messages to ensure changelogs can be generated automatically.

## 💡 Code Standards

- **Code quality**: Keep code clean, modular, and readable
- **Best practices**: Follow framework-specific best practices
- **Testing & documentation**: Include tests and documentation where applicable

---

Thank you for contributing! 🙏