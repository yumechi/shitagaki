#!/bin/sh
asciidoc -b docbook $1.adoc
pandoc -f docbook -t markdown_strict $1.xml -o $1.md
# html に変換する場合のみ
pandoc -f docbook -t html $1.xml > $1.html
