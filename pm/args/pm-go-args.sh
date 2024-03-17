#!/bin/bash

# script_dir="$(dirname "$(readlink -f "$0")")"
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."


source "$script_dir/configs/configs.sh"


family_name=""
project_name=""

new_session="false"
debug="false"


display_help() {
  echo "Usage: pm-go.sh [OPTIONS] family project"
  echo "Options:"
  echo "  family              Family of project to go"
  echo "  project             Project to create new session"
  echo "  -h, --help          Display this help message"
  echo "  -D,                 Display debug info"
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      display_help
      exit 0
      ;;
    -N)
      new_session="true"
      ;;
    -D)
      debug="true"
      ;;
    *)
      if [ "$family_name" = "" ]; then
        family_name="$1"
      elif [ "$project_name" = "" ]; then
        project_name="$1"
      else
        echo "Ignoring extra argument: $1"
      fi
      ;;
  esac
  shift
done

if [ -z "$family_name" ]; then
  echo "Argument (family name) is mandatory"
  display_help
  exit 1
fi

# if [ -z "$project_name" ]; then
#   echo "Argument (project name) is mandatory"
#   display_help
#   exit 1
# fi


if [ "$debug" = "true" ]; then
  echo "---- FROM ARGS ----"
  echo "Family Name: $family_name"
  echo "Project Name: $project_name"
  echo "------"
fi

