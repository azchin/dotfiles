#!/bin/sh

dir=${XDG_CACHE_HOME:=$HOME/.cache}
pwd > "$dir"/currentdirectory
