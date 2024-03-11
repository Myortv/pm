#!/bin/bash


projects_root_path="/codetemp"
# root path for your project families

default_shell_file="zshrc-default"
# shell file to copy to family
default_shell='zsh'
# shell to set for family

tmux_conf="tmux-default-conf"
# tmux conf file to setup for family
 
configs_path="/home/myo/.config"
# config path to copy from
configs_to_copy=("helix" "ranger")
# directories to copy from your config path
destination_config_dir=".config"
# where to copy config files (for family user)


default_pass="pass"
# default password for all users
projects_group="code_projects"
# all families have projects_group
# (needed to share something between families)
puppet_group="puppet"
# all families and YOU have puppet group
# (needed to share something between your user and) families user

project_rc_file=".pmrc"
# rc file name for projects (called with pm-go and needed for per-project automation)
default_project_rc_file="pmrc-default"
# file that will be copied as your project .rc file

# colors
RESET='\033[0m'
GREEN='\033[0;32m'
RED='\033[0;31m'
# some colors for pm

# GLOBAL CONFIGS FOR OPTIONS
pythonenv_name=".venv"
pythonenv_prefix="pythonenv"
# (for pythonvenv)

python_lsp_install="pip install \"python-lsp-server[all]\""
# lsp setup (for pythonvenv-lsp)

home_path="/home/myo"
# your main user home path (for tabby)

