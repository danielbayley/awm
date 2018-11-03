zparseopts -A TEMPLATE -- -template:
if ((#)) pushd "$*"
setopt no_case_glob
unsetopt no_match

# Read [any] workflow defaults.
for key in BundleId CreatedBy Website
  defaults read $WORKFLOWS:h/preferences/workflows/prefs.plist default$key |
  sed "s|{workflow}|$PWD:t:l|"| read $key

try awk '/^[#=-]/{ getline; print }' README* | read

typeset -A info
info[name]=${(C)${PWD:t:s/alfred-/}//[-_]/ }
info[${REPLY:+description}]=${REPLY//[^[:alnum:] .]/}
info[bundleid]=${BundleId:-com.$GITHUB_USER.$REPO}
info[createdby]=${CreatedBy:-${GIT_AUTHOR_NAME:-${(C)GITHUB_USER}}}
info[webaddress]=${Website:-https://github.com/$GITHUB_USER/$REPO/#readme}
info[version]=0.1.0

for key value (${(kv)info})
  /usr/libexec/plistbuddy -c "add :$key string $value" info.plist

git init --template $TEMPLATE/git
cp -n $TEMPLATE/*(.D) $PWD

replace '{Workflow}' $info[name] README*
replace '#workflow' $info[name]:l README*

if [ -f .git/index ]
then rm .git/index
  git checkout --force
fi

awm dev --icon
awm link
