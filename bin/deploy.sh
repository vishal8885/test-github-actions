newURL="deploy branch URL"
echo "test : old url"
URL=${URL/github.com/api.github.com/repos}"/issues/${PR}/comments"
curl -X POST $URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": "'"$newURL"'" }'