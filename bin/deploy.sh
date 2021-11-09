#!/bin/bash -e

newURL="deploy branch URL"
echo "test : old url"
if [ -n "$PR" ]; then
    SRC="github.com"
    REP="api.github.com/repos"
    echo $REPO_URL
    BUCKET_NAME_SUFFIX="tech-9618-3d95c81632dadee255d265dc"
    DIR_NAME="test"
    COMMENT=""
    URL="https://${BUCKET_NAME_SUFFIX}--${DIR_NAME}--<app-name>.static.wip.tide.co"
    declare -a APP_LIST=("webapp" "developers" "cdn" "elements" "mocktpp" "charity" "marketing" "contentful-apps" "pay" "auth-playground")
    for APP in "${APP_LIST[@]}"
      do
         COMMENT="${COMMENT}${URL/<app-name>/$APP}\n"
      done
    URL=${REPO_URL/$SRC/$REP}"/issues/${PR}/comments"
    curl -X POST $URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": "'"$COMMENT"'" }'
fi

