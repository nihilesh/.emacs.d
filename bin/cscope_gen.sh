#!/bin/sh
find -L $1 \
-not \( -path "./build-*" -prune \) \
-name '*.py' \
-o -name '*.java' \
-o -iname '*.[CH]' \
-o -name '*.cpp' \
-o -name '*.cc' \
-o -name '*.hpp'  \
-o -name '*.tac'  \
-o -name '*.tin'  \
> cscope.files

# -b: just build
# -q: create inverted index
cscope -b -q

cat cscope.files | xargs etags -a
