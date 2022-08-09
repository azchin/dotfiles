#!/bin/sh
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_EXPORT_COMPILE_COMMANDS=YES ..
ln -s ${PWD##*/}/compile_commands.json ../compile_commands.json
