#!/bin/bash



script_dir="$(dirname "$(readlink -f "$0")")"

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
# project_rc_file=".pmrc"

source "$script_dir/args/pm-create-project-args.sh"
# FROM ARGS
# project_name=""
# family_name=""
# options=()
# debug="false"



function debug(){
  echo "$projects_root_path/$family_name"
  echo "${groups[@]}"
  echo "$family_name"
 
}



function main(){
  set +e


  echo -e "${GREEN}> create project dir @ $projects_root_path/$family_name/$project_name${RESET}"
  mkdir "$projects_root_path/$family_name/$project_name"


  echo -e "${GREEN}> copy $project_rc_file file${RESET}"
  cp "$script_dir/configs/$default_project_rc_file" "$projects_root_path/$family_name/$project_name/$project_rc_file"

  echo -e "${GREEN}> change ownership (before init options)${RESET}"
  chown  -R "$family_name" "$projects_root_path/$family_name/$project_name"

  echo -e "${GREEN}> run init options${RESET}"
  echo -e "${RED}  NO OPTIONS CREATED YET${RESET}"
  for option in "${options[@]}"; do
    source "$script_dir/project_options/$option.sh" "$family_name" "$project_name"
  done


  echo  \
    >> "$projects_root_path/$family_name/$project_name/$project_rc_file"
  echo "########################################" \
    >> "$projects_root_path/$family_name/$project_name/$project_rc_file"
  echo "# custom commands to be executed no proj" \
    >> "$projects_root_path/$family_name/$project_name/$project_rc_file"
  echo "# ect startup:" \
    >> "$projects_root_path/$family_name/$project_name/$project_rc_file"
  echo "########################################" \
    >> "$projects_root_path/$family_name/$project_name/$project_rc_file"
  echo  \
    >> "$projects_root_path/$family_name/$project_name/$project_rc_file"

  echo -e "${GREEN}> change ownership (final)${RESET}"
  chown  -R "$family_name" "$projects_root_path/$family_name/$project_name"

  set -e
}

if [ "$debug" == "true" ]; then
  debug
else
  main
fi

