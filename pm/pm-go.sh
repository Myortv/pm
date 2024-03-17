#!/bin/bash

# script_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


source "$script_dir/configs/configs.sh"


source "$script_dir/args/pm-go-args.sh"

home="$projects_root_path/$family_name"

function debug(){
  echo "$projects_root_path/$family_name/$project_name"
  echo "${groups[@]}"
  echo "$family_name"
 
}

function main(){
  set +e

  amount_tmux_sessions=$(sudo -u $family_name tmux list-sessions | wc -l)

  if [ "$project_name" != "" ]; then
    postfix="-$amount_tmux_sessions"
    sudo -u $family_name tmux new-session -d -s "$project_name$postfix"

    sudo -u $family_name tmux send-keys -t "$project_name$postfix" "cd $projects_root_path/$family_name/$project_name" C-m
    sudo -u $family_name tmux send-keys -t "$project_name$postfix" "source $project_rc_file" C-m

    sudo -u $family_name tmux attach-session -t "$project_name$postfix"
  else
    sudo -u $family_name tmux attach-session -t $(sudo -u $family_name tmux list-session -F \#S | fzf)
  fi


  set -e
}

if [ "$debug" = "true" ]; then
  debug
else
  main
fi


