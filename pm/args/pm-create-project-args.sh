#!/bin/bash

# script_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."


source "$script_dir/configs/configs.sh"


project_name=""
family_name=""
options=()

debug="false"


display_help() {
  echo "Usage: pm-create-family.sh [OPTIONS]"
  echo "Options:"
  echo "  -N, --name          Specify project name (mandatory)"
  echo "  -F, --family        Specify family (mandatory)"
  echo "  -O, --options       Specify setup options"
  # echo "  -G, --groups        Specify groups"
  # echo "  -S, --shell         Specify shell"
  # echo "      --shell-file    Specify shell file"
  echo "  -h, --help          Display this help message"
  echo "  -D,                 Display debug info"
}


while [[ $# -gt 0 ]]; do
  case "$1" in
    -N|--name)
      project_name="$2"
      shift
      ;;
    -F|--family)
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
  echo "Argument (family name) is mandatory (-F, --family)"
  display_help
  exit 1
fi
if [ -z "$project_name" ]; then
  echo "Argument (project name) is mandatory (-N, --name)"
  display_help
  exit 1
fi



if [ "$debug" == "true" ]; then
  echo "---- FROM ARGS ----"
  echo "Family Name: $family_name"
  echo "Project Name: $project_name"
  echo "Options: ${options[@]}"
  echo "Debug Mode: $debug"
  echo "------"
fi

