#!/bin/bash
for f in *; do
	x=$(oggtag -l "$f")
	printf "mv \"$f\" %02d-%s-%s.mp3\n" $(echo "$x" | grep ^track | sed 's/^.* = //') $(echo "$x" | grep ^artist | sed 's/^.* = //' | perl -npe 's/ (.)/\u$1/g') $(echo "$x" | grep ^title | sed 's/^.* = //' | perl -npe 's/ (.)/\u$1/g; s/[^a-zA-Z0-9]//g')
done

exit 0
rename $MRPR 's/\s*-\s*/-/' *
rename $MRPR 's/^(\d+)\. ?/$1-/' *
rename $MRPR 's/ +/ /g' *
rename $MRPR "s/[')\]]//g" *
rename $MRPR 's/\[/_/g' *
rename $MRPR 's/\(/_/g' *
rename $MRPR 's/ (.)/\u$1/g' *
rename $MRPR 's/#(\d)/_n$1/g' *
rename $MRPR 's/#//g' *
rename $MRPR 's/_+/_/g' *
rename $MRPR 's/_\././g' *
rename $MRPR 's/^(\d+)([^-0-9])/$1-$2/' *
