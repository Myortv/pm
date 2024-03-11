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


echo -e "${GREEN}O-> (META) SETTING UP PYTHON${RESET}"
echo -e "${GREEN}  > (META) python venv${RESET}"
echo -e "${GREEN}  > (META) python lsp${RESET}"
echo -e "${GREEN}  > (META) pyenv (+virtual env)${RESET}"

source "$script_dir/family_options/pythonvenv.sh" "$family_name"
source "$script_dir/family_options/pythonvenv-lsp.sh" "$family_name"
source "$script_dir/family_options/pyenv.sh" "$family_name"

