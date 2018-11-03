#! /bin/zsh -f --glob-assign
if ([ -f icon.png ]) exit

wxh=128 # px²
alias sips="sips --resampleHeightWidthMax $wxh -s format png"

case $1 in
  *.svg) rsvg-convert -h $wxh $1 > icon.png;;

  *.app) rsrc=$1/Icon*/..namedfork/rsrc(N)

    if ((#rsrc)) then # copy [any] custom icon.
      xxd -plain $rsrc | tr -d '\n'| /usr/bin/awk -F69636e73 '{
        printf "%s %d", (length($1) + 2) / 2, "0x" substr($2, 0, 8)
      }'| read offset count

      tail -c +$offset $rsrc | head -c $count > icon.png
      sips icon.png
    else
      defaults read $1/Contents/Info.plist CFBundleIconFile | read
      sips $1/Contents/Resources/$REPLY.icns --out icon.png
    fi;;

  *) defaults read $PWD/info bundleid | read
    if [ -f icon.svg ]
    then exec $0 icon.svg
    elif defaults domains | grep -q $REPLY
    then exec $0 `mdfind kMDItemCFBundleIdentifier = $REPLY`
    fi;;
esac
