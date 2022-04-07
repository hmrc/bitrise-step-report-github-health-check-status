# Report Github Health Check Status

Updates the Github health status for a given pull request

## How to use this Step

Add the following to your `bitrise.yml`
```
- git::https://github.com/hmrc/bitrise-step-report-github-health-check-status.git@main:
    title: Report Github Health Check Status
    is_always_run: true
```

### Environment Variables

Set an environment variable called `GITHUB_TOKEN` in the secrets tab of your Bitrise workflow editor. The token needs to have `repo:status` permissions.
\
\
Some internal Bitrise environment variables are also used:
* `BITRISEIO_GIT_REPOSITORY_SLUG`
* `BITRISE_GIT_COMMIT`
* `BITRISE_BUILD_URL`
* `BITRISEIO_GIT_REPOSITORY_SLUG`
* `BITRISE_GIT_BRANCH`
* `BITRISE_TRIGGERED_WORKFLOW_ID`
