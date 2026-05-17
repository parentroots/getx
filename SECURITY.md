# Security Policy

## Supported Versions

The latest version of this template is supported.

## Reporting A Vulnerability

Please do not open public issues for security vulnerabilities.

Report security concerns privately to the repository maintainer. Include:

- A clear description of the problem
- Affected files or dependencies
- Steps to reproduce when possible
- Suggested mitigation if you have one

## Secret Handling

This template must not include real secrets. Keep these out of Git:

- `.env`
- Firebase service account files
- signing keys
- API keys
- private certificates
- provisioning profiles

Use `.env.example` and documentation for placeholders only.
