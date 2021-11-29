#!/usr/bin/env bash



gokuFile=/tmp/goku.edn
cat "$(dirname "$0")"/karabiner.edn > $gokuFile

sed -i '' -e '/;include:disabled-buttons.edn/r./disabled-buttons.edn' $gokuFile
sed -i '' -e '/;include:osl-nav-layer.edn/r./osl-nav-layer.edn' $gokuFile
sed -i '' -e '/;include:osl-character-layer.edn/r./osl-character-layer.edn' $gokuFile
sed -i '' -e '/;include:raise-layer.edn/r./raise-layer.edn' $gokuFile
sed -i '' -e '/;include:lower-layer.edn/r./lower-layer.edn' $gokuFile
sed -i '' -e '/;include:app-layer.edn/r./app-layer.edn' $gokuFile
sed -i '' -e '/;include:fun-layer.edn/r./fun-layer.edn' $gokuFile
sed -i '' -e '/;include:num-app-layer.edn/r./num-app-layer.edn' $gokuFile
sed -i '' -e '/;include:adjusted-typing-layer.edn/r./adjusted-typing-layer.edn' $gokuFile

#cat $gokuFile

/usr/local/bin/goku -c $gokuFile

rm $gokuFile
