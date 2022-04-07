# Report Github Health Check Status

Updates the Github health status for a given pull request

## How to use this Step

Add the following to your `bitrise.yml`
```
- git::https://github.com/hmrc/bitrise-step-report-github-health-check-status.git@main:
    title: Report Github Health Check Status
    is_always_run: true
```