# script_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."


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

family_name=$1
# project_name=$2

echo -e "${GREEN}O-> setting python venv${RESET}"
python -m venv "$projects_root_path/$family_name/$pythonenv_name" --prompt "$pythonenv_prefix"

echo "# FROM family_options/pythonvenv.sh" >> \
  "$projects_root_path/$family_name/.$default_shell"rc

echo "source $projects_root_path/$family_name/$pythonenv_name/bin/activate" >> \
  "$projects_root_path/$family_name/.$default_shell"rc

echo "# END family_options/pythonvenv.sh" >> \
  "$projects_root_path/$family_name/.$default_shell"rc

echo  >> \
  "$projects_root_path/$family_name/.$default_shell"rc


