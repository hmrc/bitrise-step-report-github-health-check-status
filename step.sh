#!/usr/bin/env bash
# fail if any commands fails
set -e

echo "Env variables"
echo "BITRISEIO_GIT_REPOSITORY_SLUG = $BITRISEIO_GIT_REPOSITORY_SLUG"
echo "BITRISE_GIT_COMMIT = $BITRISE_GIT_COMMIT"
echo "BITRISE_GIT_TAG = $BITRISE_GIT_TAG"
echo "BITRISE_BUILD_URL = $BITRISE_BUILD_URL"
echo "BITRISEIO_GIT_REPOSITORY_SLUG = $BITRISEIO_GIT_REPOSITORY_SLUG"
echo "BITRISE_GIT_BRANCH = $BITRISE_GIT_BRANCH"
echo "BITRISE_TRIGGERED_WORKFLOW_ID = $BITRISE_TRIGGERED_WORKFLOW_ID"

SHA=$BITRISE_GIT_COMMIT
if [ -z "${SHA}" ]; then
    SHA=$GIT_CLONE_COMMIT_HASH
fi

echo "SHA = $SHA"

URL="https://api.github.com/repos/hmrc/$BITRISEIO_GIT_REPOSITORY_SLUG/statuses/$SHA"
echo "URL = $URL"

STATUS_DESCRIPTION="Failed"
STEP_STATUS="failure"

if [ "$BITRISE_BUILD_STATUS" == 0 ]; then
    STEP_STATUS="success"
    STATUS_DESCRIPTION="Passed"
fi

STATUSCODE=$(curl --silent --output /dev/stderr --write-out "%{http_code}" \
    -X POST -H 'Accept: application/vnd.github.v3+json' \
    -H 'Authorization: token '"$GITHUB_TOKEN"'' $URL \
    -d '{"state":"'"$STEP_STATUS"'", "target_url": "'"$BITRISE_BUILD_URL"'", "description": "'"$STATUS_DESCRIPTION"' - '"$BITRISEIO_GIT_REPOSITORY_SLUG"'", "context": "ci/bitrise/'"$BITRISE_GIT_BRANCH"'/'"$BITRISE_TRIGGERED_WORKFLOW_ID"'"}'\
)

if (($STATUSCODE >= 200 && $STATUSCODE < 300)); then
    if [ "$STEP_STATUS" == "failure" ]; then
        exit 1
    fi
else
    echo "curl failed with status code $STATUSCODE"
    exit 1
fi

