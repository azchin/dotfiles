#!/bin/sh

# to be used with `exec`

dir=${XDG_CACHE_HOME:=$HOME/.cache}
echo -n "cd "
cat "$dir"/currentdirectory
