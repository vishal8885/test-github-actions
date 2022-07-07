#!/bin/bash -e

BUCKET_NAME_SUFFIX=tide-web-apps
GITHUB_REF=$(echo -e "$GITHUB_REF" | tr -d '"' | cut -d'/' -f3-)


if [ "$S3_TARGET" == "branch" ]; then
  # Branch name, lowercase
  export BRANCH_NAME=$(echo "${GITHUB_REF}" | tr [:upper:] [:lower:])

  # JIRA ticket name, if included in branch name
  export TICKET_NAME=$(echo ${BRANCH_NAME} | sed -E 's/^(feature\/)?([a-z]+-[0-9]+).*$/\2/')

  # md5 hash of branch name, truncated to 24 characters
  export HASH=$(echo "${BRANCH_NAME}" | md5sum - | cut -c 1-24)

  if [ "${BRANCH_NAME}" == "${TICKET_NAME}" ]; then
    # Use just the hash
    export DIR_NAME="${HASH}"
  else
    # Use the ticket name and hash together
    export DIR_NAME="${TICKET_NAME}-${HASH}"
  fi
else
  export DIR_NAME="$S3_TARGET"
fi

echo "test : old url"
if [ -n "$PR" ]; then
    COMMENT=""
    URL="https://${BUCKET_NAME_SUFFIX}--${DIR_NAME}--<app-name>.static.wip.tide.co"
    declare -a APP_LIST=("webapp" "developers" "cdn" "elements" "mocktpp" "charity" "marketing" "contentful-apps" "pay" "auth-playground")
    for APP in "${APP_LIST[@]}"
      do
         COMMENT="${COMMENT}${URL/<app-name>/$APP}\n"
      done
    curl -X POST $COMMENT_URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": "'"$COMMENT"'" }'
fi
