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

  echo $new_session
  amount_tmux_sessions=$(sudo -u $family_name tmux list-sessions | wc -l)

  # if sudo -u $family_name tmux has-session 2>/dev/null; then
  if sudo -u $family_name tmux has-session 2>/dev/null && [ "$new_session" == "true" ]; then
    # create new session
    echo 'catch -N, create new session'
    postfix="-$amount_tmux_sessions"
    sudo -u $family_name tmux new-session -d -s "$project_name$postfix"

    sudo -u $family_name tmux send-keys -t "$project_name$postfix" "cd $projects_root_path/$family_name/$project_name" C-m
    sudo -u $family_name tmux send-keys -t "$project_name$postfix" "source $project_rc_file" C-m

    sudo -u $family_name tmux attach-session -t "$project_name$postfix"

  elif sudo -u $family_name tmux has-session 2>/dev/null; then
    echo 'session exsists, attach to top session'
    postfix="-$(($amount_tmux_sessions - 1))"
    echo $postfix
    sudo -u $family_name tmux attach-session -t "$project_name$postfix"
  else
    postfix="-$amount_tmux_sessions"
    echo "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
    sudo -u $family_name tmux new-session -d -s "$project_name$postfix"

    sudo -u $family_name tmux send-keys -t "$project_name$postfix" "cd $projects_root_path/$family_name/$project_name" C-m
    sudo -u $family_name tmux send-keys -t "$project_name$postfix" "source $project_rc_file" C-m


    # sudo -u $family_name chmod -R 1777 "/tmp/tmux-$(id -u $family_name)"
    # sudo -u $family_name echo "/tmp/tmux-$(id -u $family_name)/$project_name"
    sudo -u $family_name tmux attach-session -t "$project_name$postfix"
  fi

  # sudo -u $family_name tmux new-session -d -s "$project_name"

  # sudo -u $family_name tmux send-keys -t "$project_name" "cd $projects_root_path/$family_name/$project_name" C-m
  # sudo -u $family_name tmux send-keys -t "$project_name" "source $project_rc_file" C-m


  # # sudo -u $family_name chmod -R 1777 "/tmp/tmux-$(id -u $family_name)"
  # # sudo -u $family_name echo "/tmp/tmux-$(id -u $family_name)/$project_name"
  # sudo -u $family_name tmux attach-session -t "$project_name"


  set -e
}

if [ "$debug" = "true" ]; then
  debug
else
  main
fi


