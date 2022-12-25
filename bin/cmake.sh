#!/bin/sh
rm CMakeCache.txt
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES -DLSP=1 ..
ln -sf ${PWD##*/}/compile_commands.json ../compile_commands.json

rm CMakeCache.txt
cmake ..
