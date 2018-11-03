#! /bin/zsh -f
source $0:h/libexec/env.*

case ${1:---help} in
  --help|-h) less --chop-long-lines $DOC/help.txt;;
  --version|-v) print v$VERSION;;
  *able) shift
    for info in $WORKFLOWS/${^@/alfred-}/info.plist
      plutil -replace disabled -bool $1:s/disable/true $info;;

  # Development
  init) source $0:h/libexec/$1.* ${@:2};;
  dev*) source $0:h/libexec/dev*.*;;

  link) ln -sn $PWD $WORKFLOWS;;
  unlink) $1 $WORKFLOWS/$PWD:t;;

  test|t) try npm test or ${GIT_HOOKS:-.git/hooks}/pre-commit;;
  *publish) $0 test and source $0:h/libexec/$1.*;;
  *) brew alfred $@
esac
