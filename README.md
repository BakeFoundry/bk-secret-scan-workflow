# BakeFoundry Secret Scan Action

This GitHub Action scans your repository for hardcoded secrets (API keys, passwords, tokens) using **Trivy**. It is designed to act as a gatekeeper, preventing sensitive information from being merged into your codebase.

## Intention & Context
Security should be proactive, not reactive. The intention of this workflow is to **shift security left**, catching potential leaks at the Pull Request stage before they become part of the history.
By integrating secret scanning directly into the CI/CD pipeline, we ensure that:
1.  Secrets are detected immediately.
2.  Builds fail if critical secrets are found.
3.  Remediation is enforced before code review begins.

## How this helps

### 👩‍💻 For Developers
-   **Immediate Feedback**: You get instant notification if you accidentally commit a secret.
-   **Clear Visibility**: The action posts a comment on your PR with a table showing exactly **what** was found and **where** (file and line number).
-   **Actionable**: It tells you the severity (e.g., `CRITICAL`, `HIGH`), so you know what needs immediate attention (revocation and removal).

### 🕵️‍♂️ For Approvers / Reviewers
-   **Confidence**: You can review code knowing that automated scanners have already checked for common credentials
-   **Efficiency**: You don't need to manually hunt for API keys in diffs.
-   **Gatekeeping**: The PR comment acts as a seal of approval (✅ No Secrets Found) or a warning sign (⚠️ Secrets Detected), helping you decide whether to merge or request changes.

## Usage

Create a workflow file (e.g., `.github/workflows/security.yml`) in your repository:

```yaml
name: Security Scan

on:
  pull_request:
  push:
    branches: [ main ]

jobs:
  secret-scan:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Code
        uses: actions/checkout@v4

      - name: Scan for Secrets
        uses: BakeFoundry/bk-secret-scan-workflow@v1
```
