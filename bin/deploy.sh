newURL="deploy branch URL"
echo "test : old url"
curl -X POST $URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": "'"$newURL"'" }'