URL="deploy branch URL"
echo "test : old url"
echo "new"
echo "new"
# curl -X POST $URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": $URL }'