setopt extended_glob no_case_glob null_glob
alias zparseopts='zparseopts -D -E'
zparseopts -a include -- i+: -include+:
zparseopts -M -A ghr -- n t:=n -title:=n b d:=b -description:=b -describe:=b

version () {
  case ${1#[v-]} in
    -*preview) exec unzip -l $NAME.alfredworkflow;;
    (#b)([0-9]).([0-9]).([0-9])) read M m p <<< $match;;
    M|[Mm]aj*) ((M+=1)); m=0 p=0;;
    m|min*) ((m+=1));;
    p|pat*) ((p+=1));;
    ^-*amend) exit 1
  esac
}
version ${LATEST:-0.0.0}
version ${1:-minor}

trap 'try git stash pop --index' EXIT ERR
git stash --include-untracked --keep-index | grep -v No
awm dev --icon

alias read="read -d ''"
ignore=('objects/*' LICEN?E* README*)

if [ -f .alfredignore ]
then exclude=@.alfredignore
  git ls-files --ignored --others --directory -X .git/info/exclude | read -A
  for i ($ignore[1] ${(M)^reply:#*/}\* ${reply:#*/})
    unless (grep -q $i .alfredignore) print $i >> .alfredignore
else
  git check-ignore *(M) | read -A
  ignore+=(${(M)^reply:#*/}\* ${reply:#*/})
  include=(icon.* ${~include:#-*})
  exclude=(${ignore:|include})
fi

coproc zip -r --symlinks --filesync -X {$NAME,^*}.alfredworkflow -x $exclude
read -pE
case ${LATEST+$REPLY} in *current) exit
esac

ghr -replace ${(kv)ghr} -- v$M.$m.$p $NAME.alfredworkflow
