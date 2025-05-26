# RELEASE PROCESS

This document describes our streamlined process for preparing and managing production releases, now automated with `release-please`.

## Branch Overview

* **`main`**: The production branch. Contains only thoroughly tested and released code. It is updated by merging the `develop` branch after `release-please` has completed its work.
* **`develop`**: The primary integration branch for active feature and bug fix development. This is where `release-please` monitors commits, suggests version bumps, and prepares release notes.
* **`hotfix/*`**: (No change) Emergency branches for critical fixes directly to `main`.

## Automated Release with `release-please`

Our release process is driven by `release-please`, which automates version management, changelog generation, and GitHub Release creation based on our [Conventional Commits](https://www.conventionalcommits.org/) standards.

### How it Works:

1.  **Continuous Release PR on `develop`**:
    * As features and bug fixes (with Conventional Commits like `feat:` or `fix:`) are merged into `develop`, `release-please` automatically creates and maintains a special Pull Request (e.g., `chore(release): X.Y.Z`) on the `develop` branch.
    * This Release PR's title and content will reflect the proposed next version number (e.g., `1.2.0`) and a detailed list of changes since the last release. It also includes the necessary update to the `pubspec.yaml` file.

2.  **Triggering a Release**:
    * When the `develop` branch is stable and ready for a new production release, a designated maintainer will **review and merge** the `release-please` generated Pull Request into `develop`.
    * **This single merge action triggers the following automation**:
        * `release-please` automatically creates a **Git Tag** (e.g., `v1.2.0`) on the `develop` branch.
        * `release-please` automatically creates a corresponding **GitHub Release** with detailed release notes (derived from your Conventional Commits).
        * The `pubspec.yaml` file on `develop` will be updated with the new version number.
        * The `CHANGELOG.md` file (if configured) will be updated on `develop`.

3.  **Deployment to Production**:
    * Once the `release-please` PR has been merged into `develop` and the new Git Tag/GitHub Release are created, the final step is to **merge the `develop` branch into `main`**.
    * This merge to `main` will trigger our CI/CD pipeline, which is responsible for deploying the new tagged version to production.

## Tagging

* Release tags (e.g., `v1.2.0`) are automatically created on the `develop` branch by `release-please` when its Release PR is merged.
* These tags will become part of the `main` branch's history after `develop` is merged into `main`.
* Tags follow semantic versioning: `v<major>.<minor>.<patch>`.

## Example Workflow (Simplified)

1.  Developers finish features/bug fixes and merge into `develop` (using Conventional Commits).
2.  `release-please` automatically maintains a "Release PR" on `develop`, reflecting the next potential version and changes.
3.  When ready for release, a maintainer reviews and **merges the `release-please` PR into `develop`**.
4.  `release-please` automatically creates the Git Tag (e.g., `v1.2.0`) and GitHub Release on `develop`.
5.  A maintainer **merges `develop` into `main`**.
6.  CI/CD deploys from `main` (using the new tag).

---

Thank you for contributing! 🙏