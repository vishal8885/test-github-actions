newURL="deploy branch URL"
echo "test : old url"
echo ${{ github.event.pull_request.comments_url }}
echo ${{ secrets.GITHUB_TOKEN }}
curl -X POST $URL -H "Content-Type: application/json" -H "Authorization: token $GITHUB_TOKEN" --data '{ "body": "'"$newURL"'" }'