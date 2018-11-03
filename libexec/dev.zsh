#! /bin/zsh -f
case $1 in
  --icon) exec $0:h/icon.* "${*:2}";;

  https://github.*) git clone $1 --template $0:h:h/template/git;;

  *.alfredworkflow*) mkdir $1:t:r
    curl -L $1 | tar zx -C $1:t:r;;

  */*) exec $0 https://github.com/$1:h/alfred-$1:t:s/alfred-/;;

  *) brew cask _stanza url alfred-${1/alfred-} | read
    case $REPLY in
      https://github.*) exec $0 $REPLY:h:h:h:h.git;;
      *) exec $0 $REPLY
    esac;;
esac
awm init $1:t:r
