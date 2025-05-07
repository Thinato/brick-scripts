#!/bin/bash

SESSION="brick"
SESSION_DIR="$HOME/repos/brick"

tmux kill-session -t $SESSION

# Start a new tmux session in the server directory
tmux new-session -d -s $SESSION -c "$SESSION_DIR/server"

tmux rename-window "main"

# Pane 1: yarn start:dev
tmux send-keys "git pull" C-m
tmux send-keys "yarn start:dev"

# Split right: yarn build --watch (pane 1 -> pane 2)
tmux split-window -h -c "$SESSION_DIR/web-core"
tmux send-keys "git pull" C-m
tmux send-keys "npm run dev" C-m

# Split bottom-right: docker-compose (pane 2 -> pane 3)
tmux split-window -v -c "$SESSION_DIR/server"
tmux send-keys "sudo docker-compose -f scripts/docker-compose.postgres.yml up" 

# Split below it: web-core (pane 0 -> pane 4)
tmux new-window -c "$SESSION_DIR/server"
tmux send-keys "yarn build --watch" C-m 
tmux select-window -t 1

# Optional: rearrange if needed or focus a specific pane
# tmux select-pane -t 0

# Attach to the session
tmux attach-session -t $SESSION
