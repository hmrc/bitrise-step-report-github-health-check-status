#!/usr/bin/env bash
# fail if any commands fails
set -e

STEP_STATUS="failure"

if [ "$BITRISE_BUILD_STATUS" == 0 ]; then
    STEP_STATUS="success"
fi

STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" \
    -X POST -H 'Accept: application/vnd.github.v3+json' \
    -H 'Authorization: token '"$GITHUB_TOKEN"'' https://api.github.com/repos/hmrc/$BITRISEIO_GIT_REPOSITORY_SLUG/statuses/$BITRISE_GIT_COMMIT \
    -d '{"state":"'"$STEP_STATUS"'", "target_url": "'"$BITRISE_BUILD_URL"'", "description": "'"$BITRISEIO_GIT_REPOSITORY_SLUG"'", "context": "ci/bitrise/'"$BITRISE_GIT_BRANCH"'/'"$BITRISE_TRIGGERED_WORKFLOW_ID"'"}'\
)

if (($STATUSCODE >= 200 && $STATUSCODE < 300)); then
    if [ "$STEP_STATUS" == "failure" ]; then
        exit 1
    fi
else
    echo "curl failed"
    exit 1
fi

