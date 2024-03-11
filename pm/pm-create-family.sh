#!/bin/bash

# script_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


source "$script_dir/configs/configs.sh"
# FORM CONFIGS
# projects_root_path="/codetemp"
# go_script_name=".pm-go.sh"
# default_shell_file="zshrc-default"
# default_shell='zsh'
# configs_to_copy=("helix" "ranger")
# configs_path="/home/myo/.config"
# destination_config_dir=".config"
# default_pass="pass"
# projects_group="code_projects"
# puppet_group="puppet"

source "$script_dir/args/pm-create-family-args.sh"
# FROM ARGS
# family_name=""
# options=()
# add_puppet="false"
# groups=("$projects_group")
# shell="$default_shell"
# shell_file="$default_shell_file"
# pass="$default_pass"
# debug="false"


join_by() {
    local IFS="$1"
    shift
    echo "$*"
}

function debug(){
  echo "$projects_root_path/$family_name"
  echo -e "${groups[@]}"
  echo "$family_name"
  
  echo $(join_by ", " "${groups[@]}")

  echo -e "${GREEN}> apply init options${RESET}"
  for option in "${options[@]}"; do
    source "$script_dir/family_options/$option.sh" $family_name
  done
}

function main(){
  set +e


  echo -e "${GREEN}> create user${RESET}"
  useradd \
    -m \
    -d "$projects_root_path/$family_name" \
    -G $(join_by ", " "${groups[@]}") \
    -s "/bin/$shell" \
    "$family_name" \


  echo -e "${GREEN}> set password${RESET}"
  echo "$family_name:$pass" | sudo chpasswd
  

  echo -e "${GREEN}> copy .cofings${RESET}"
  mkdir "$projects_root_path/$family_name/$destination_config_dir"
  for config_file in "${configs_to_copy[@]}"; do
    cp \
      "$configs_path/$config_file" \
      "$projects_root_path/$family_name/$destination_config_dir" \
      -r
  done


  echo -e "${GREEN}> copy tmux config${RESET}"
  cp "$script_dir/configs/$tmux_conf" "$projects_root_path/$family_name/.tmux.conf"
  sudo chown "$family_name" "$projects_root_path/$family_name/.tmux.conf"


  echo -e "${GREEN}> copy shell file${RESET}"
  cp "$script_dir/configs/$default_shell_file" "$projects_root_path/$family_name/.$shell"rc


  echo -e "${GREEN}> change ownership (before init options)${RESET}"
  if [ "$add_puppet" == "true" ]; then
    chown  -R "$family_name:$puppet_group" "$projects_root_path/$family_name"
  else
    chown  -R "$family_name" "$projects_root_path/$family_name"
  fi


  echo -e "${GREEN}> apply init options${RESET}"
  for option in "${options[@]}"; do
    source "$script_dir/family_options/$option.sh" "$family_name"
  done


  echo -e "${GREEN}> change ownership (final)${RESET}"
  if [ "$add_puppet" == "true" ]; then
    chown  -R "$family_name:$puppet_group" "$projects_root_path/$family_name"
  else
    chown  -R "$family_name" "$projects_root_path/$family_name"
  fi
  
  set -e
}


if [ "$debug" == "true" ]; then
  debug
else
  main
fi
