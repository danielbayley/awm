if ((#)) LATEST=v${1#v}

API=https://api.github.com/repos/$GITHUB_USER/$REPO/releases
curl () { command curl -L --silent ${@:2} "$API/$1?access_token=$GITHUB_TOKEN"}

curl tags/$LATEST | json id | read
if (($+REPLY)) then
  curl $REPLY --request DELETE or exit 1

  git push $REMOTE :refs/tags/$LATEST
  git tag --delete $LATEST
fi
