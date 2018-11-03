setopt all_export
alias zparseopts='zparseopts -D -E -K'
alias unless='if !'
alias -g and='&&'
alias -g or='||'
try () { $@ 2> /dev/null }
json () { ruby -r json -e "p JSON[STDIN.read]['$1']"}
replace () { perl -pi -e "s|$1|$2|g" $3 }

brew --cellar awm | read
ls $REPLY | read VERSION
DOC=$REPLY/$VERSION/share/doc/awm

git config user.name | read GIT_AUTHOR_NAME
git config core.hooksPath | read GIT_HOOKS

try git remote --verbose | read REMOTE URL
GITHUB_USER=$URL:h:t
REPO=$URL:t:r

try defaults read $PWD/info name | read NAME

brew alfred --workflows | read WORKFLOWS
mkdir -p $WORKFLOWS

TEMPLATE=${HOMEBREW_AWM_TEMPLATE:=$0:h:h/template}

try git tag | tail -n 1 | read LATEST
