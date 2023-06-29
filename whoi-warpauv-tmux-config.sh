#!/bin/sh 
tmux new-session -s "warpauv" -d
tmux split-window -h
tmux split-window -v
tmux select-pane -L
tmux split-window -v
tmux -2 attach-session -d
