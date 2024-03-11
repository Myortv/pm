#!/bin/bash

# script_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."


source "$script_dir/configs/configs.sh"


family_name=""
options=()
add_puppet="false"
groups=("$projects_group")
shell="$default_shell"
shell_file="$default_shell_file"
pass="$default_pass"

debug="false"

display_help() {
  echo "Usage: pm-create-family.sh [OPTIONS]"
  echo "Options:"
  echo "  -N, --name          Specify family name (mandatory)"
  echo "  -P, --pass          Specify user password (default to $default_pass)"
  echo "  -O, --options       Specify setup options"
  echo "  -G, --groups        Specify groups"
  echo "  -S, --shell         Specify shell"
  echo "      --shell-file    Specify shell file"
  echo "  -h, --help          Display this help message"
  echo "  -D,                 Display debug info"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -N|--name)
      family_name="$2"
      shift
      ;;
    -O|--options)
      while [[ $# -gt 0 ]] && [[ "$2" != -* ]]; do
        if [[ ! -z "$2" ]]; then
          options+=("$2")
        fi
        shift
      done
      ;;
    -G|--groups)
      while [[ $# -gt 0 ]] && [[ "$2" != -* ]]; do
        if [[ ! -z "$2" ]]; then
          groups+=("$2")
        fi
        shift
      done
      ;;
    -S|--shell)
      shell="$2"
      shift
      ;;
    -P|--pass)
      pass="$2"
      shift
      ;;
    --shell-file)
      shell_file="$2"
      shift
      ;;
    --add-puppet)
      add_puppet="true"
      ;;
    -h|--help)
      display_help
      exit 0
      ;;
    -D)
      debug="true"
      ;;
    *)
      echo "Invalid argument: $1" >&2
      exit 1
      ;;
  esac
  shift
done

if [ -z "$family_name" ]; then
  echo "Argument (family name) is mandatory (-N, --name)"
  display_help
  exit 1
fi



if [ "$debug" == "true" ]; then
  echo "---- FROM ARGS ----"
  echo "Family Name: $family_name"
  echo "Options: ${options[@]}"
  echo "Groups: ${groups[@]}"
  echo "Shell: $shell"
  echo "Shell File: $shell_file"
  echo "------"
fi

