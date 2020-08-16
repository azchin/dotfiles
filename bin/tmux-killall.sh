#!/bin/sh
tmux ls -F "#S" | xargs -I _sess tmux kill-session -t _sess
