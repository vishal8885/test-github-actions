newURL="deploy branch URL"
echo "test : old url"
SRC="github.com"
REP="api.github.com/repos"
echo $REPO_URL
URL=${REPO_URL/$SRC/$REP}"/issues/${PR}/comments"
curl -X POST $URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": "'"$newURL"'" }'