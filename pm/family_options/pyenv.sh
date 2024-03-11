# script_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
# need update (to support both zsh and bash shells)

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

pyenv_virtualenv_download_link="https://github.com/pyenv/pyenv-virtualenv.git"

home="$projects_root_path/$family_name"




echo -e "${GREEN}O-> setting up pyenv${RESET}"

echo "# FROM family_options/pyenv.sh" >> \
  "$projects_root_path/$family_name/.$default_shell"rc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> "$home/.zshrc"
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> "$home/.zshrc"
echo 'eval "$(pyenv init -)"' >> "$home/.zshrc"
mkdir "$home/.pyenv"
git clone "$pyenv_virtualenv_download_link" "$home/.pyenv/plugins/pyenv-virtualenv"

echo 'eval "$(pyenv virtualenv-init -)"' >>  "$home/.zshrc"
echo "# END family_options/pyenv.sh" >> \
  "$projects_root_path/$family_name/.$default_shell"rc
echo  >> \
  "$projects_root_path/$family_name/.$default_shell"rc

