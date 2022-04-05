#!/usr/bin/env bash
# fail if any commands fails
set -e
# debug log
set -x

STATUS="failure"

if [ "$BITRISE_BUILD_STATUS" == 0 ]; then
    STATUS="success"
fi

curl \
-X POST -H 'Accept: application/vnd.github.v3+json' \
-H 'Authorization: token '"$GITHUB_TOKEN"'' https://api.github.com/repos/hmrc/$REPO_NAME/statuses/$BITRISE_GIT_COMMIT \
-d '{"state":"'"$STATUS"'", "target_url": "'"$BITRISE_BUILD_URL"'", "description": "'"$BITRISEIO_GIT_REPOSITORY_SLUG"'", "context": "ci/bitrise/'"$BITRISE_GIT_BRANCH"'/'"$BITRISE_TRIGGERED_WORKFLOW_ID"'"}'

if [ "$STATUS" == "failure" ]; then
    exit 1
fi