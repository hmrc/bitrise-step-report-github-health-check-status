# Report Github Health Check Status

Updates the Github health status for a given pull request

## How to use this Step

Add the following to your `bitrise.yml`
```
- git::https://github.com/hmrc/bitrise-step-report-github-health-check-status.git@main:
    title: Report Github Health Check Status
    is_always_run: true
```

* The step must be executed subsequent to the `git clone` step.
* This is because this step uses environment variables the `git clone` step outputs.

### Environment Variables

Set an environment variable called `GITHUB_TOKEN` in the secrets tab of your Bitrise workflow editor. The token needs to have `repo:status` permissions.
\
\
Some internal Bitrise environment variables are also used:
* `BITRISEIO_GIT_REPOSITORY_SLUG`
* `BITRISE_GIT_COMMIT`
* `BITRISE_GIT_TAG`
* `BITRISE_BUILD_URL`
* `BITRISEIO_GIT_REPOSITORY_SLUG`
* `BITRISE_GIT_BRANCH`
* `BITRISE_TRIGGERED_WORKFLOW_ID`
* `GIT_CLONE_COMMIT_HASH`