script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$script_dir/configs/configs.sh"


echo -e "${GREEN}INITIALIZE PM${RESET}"
echo -e "${GREEN}*************${RESET}"


if ! command -v tmux >/dev/null 2>&1; then
  echo -e "${RED} TMUX NEEDED AS DEPENDENCY TO RUN pm-go${RESET}"
  exit 1
fi

echo -e "${GREEN}> add puppet group ($puppet_group)${RESET}"
groupadd $puppet_group
echo -e "${RED}* add your user to puppet if needed *${RESET}"
echo -e "${RED}  usermod -aG $puppet_group <username>${RESET}"

echo -e "${GREEN}> add project group ($project_group)${RESET}"
groupadd $projects_group
echo -e "${RED}* add your user to project group if needed *${RESET}"
echo -e "${RED}  usermod -aG $projects_group <username>${RESET}"

echo -e "${GREEN}> add projects home directory ($projects_root_path)${RESET}"
mkdir $projects_root_path

echo -e "${GREEN}> add make scripts executable ($projects_root_path)${RESET}"
chmod -R a+x $script_dir

echo -e "${GREEN}*************${RESET}"
echo -e "${GREEN}INIT FINISHED${RESET}"
