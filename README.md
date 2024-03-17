# Manage your projects from terminal with ease
PM is a few bash scripts that form a simple utility for managing local projects.

**PM uses tmux as a dependency** to run project sessions. PM can still be used to generate projects, but some of its functionality will not be available without tmux. If it works out in the future to drop tmux as a dependency that would be great, but at the moment the alternatives look like something worse and writing your own solution seems pointless.


#### Reasons:
* When working from a terminal, it can take several steps between starting the terminal emulator and getting started. (cd to directory with project, activate environment, and so on)
* Often you have to create some similar projects and repeat the step of customizing the same projects. This becomes especially true if you do some automation. (e.g. some standard script)
* Often, when creating many projects following the second point, many similar dependencies are created, which is not so critical, but I wish it was a bit more efficient.

# So what does this pm thing do?
Pm creates families of projects and the projects themselves within those families. <br>
Each family represents a separate user, so that each family is as independent as possible from each other and from the main user of the system. <br>
Pm makes it possible to "go" to the desired project. Thus, it performs not only initialization for the family (using shell .rc files) but also for the project (using its own .rc file). <br>
In addition, pm provides "options" to automate the creation of projects and project families. <br>

| command | description |
| ------- | ----------- |
| pm-create-family.sh | Creates a family of projects. Projects within a family share the same user on the system and have similar global dependencies. |
| pm-create-project.sh | Creates a project within a family. The project can have special dependencies and automation. |
| pm-go.sh | Creates a tmux session that connects to the project. |
| pm-init.sh | Installs pm. |


# Installation


To get started, clone this repository in a directory you are comfortable with (for me it's ~/sources).

```
git clone https://github.com/Myortv/pm.git
```

Allow to execute scripts

```
sudo chmod -R a+x pm
```

You'll probably want to add scripts to your PATH. To do this, add the following lines to your .rc file (I use zsh, so for me it's ~/.zshrc).
(change the path to the desired path)


```
# FOR PM	
export PATH="$PATH:$HOME/sources/pm/pm"
```

Restart your terminal shell (or execute)

```
exec $SHELL
```

Now the pm commands will be available! But before you can fully start using them, you will need to configure pm. <br>
After completing the setup (or if you are satisfied with the default settings), you should invoke:

```
sudo pm-init.sh
```

> ALL pm commands are called with elevated privileges (sudo). This is due to the fact that all users that are created by pm during the creation of a product family are independent of your main system user.

# confing

In order to view the settings you need to go to the `pm/configs` directory <br>
The following files:

| file | purpose |
|---|---|
| configs.sh | Basic pm settings |
| pmrc-default | rc file for the project. This is a project-level automation file |
| tmux-default-conf | File with tmux settings for a family of projects |
| zshrc-default | rc file (in this case for zsh). Needed for configuration and automation at the project family level |

First of all, we should look at the contents of configs.sh. All pm settings are there.
It is worth noting the following variables that will most likely be useful to you:
```
projects_root_path="/codetemp"
# root path for your project families

default_shell='zsh'
#shell to set for family
 
configs_path="/home/myo/.config"
# config path to copy from
configs_to_copy=("helix" "ranger")
# directories to copy from your config path

```
`projects_root_path` - directory where all families will be created. Works like `/home` for users.
`default_shell` - shell to setup for family user.
`configs_path` - path to your .config directory, where stored configs for all your apps. I have there ranger and helix configs and i want to have them on my family user too.
`configs_to_copy` - is directories i want to copy inside my .configs.
So, basically, this will copy my `~/.config/helix` `~/.config/ranger` to family user's `.config`.

# Examples of using

```
sudo pm-create-family.sh -N minimal
```
```
sudo pm-create-family.sh -N docker_family -P secretpass -G docker ollama puppet
```
```
sudo pm-create-family.sh -N python_projects -O python
```
```
sudo pm-create-family.sh -N with_bash_shell -S bash --shell-file default-bashrc
```

```
sudo pm-create-project.sh -N minimal -F docker_family
```
```
sudo pm-create-project.sh -N options -F docker_family -O readme
```
(note that this projects options are not present in repo)

```
sudo pm-go.sh docker_family minimal
```
```
sudo pm-go.sh docker_family minimal -N
```
(will open new tmux session. Note that launching multiple session can be confising)
>note that you don't have to use sudo for pm-go. I'm configured to use sudo without a password, so I just need to write pm-go (all the necessary calls to sudo occur inside the script and are needed to perform actions on the part of the family user)

# Creating custom options

You will most likely want to add some custom options. Let's make a simple custom option that will create a README file in the project upon creation.


first, let's add this line to our configs/configs.sh
```
readme_file="other/readme.md"
```
Then we’ll write something in `other/readme.md`. For example:
```
I manage this project with PM!
```

Finally, let's create an options file that will be called when the project is generated. Let's open projects_options/readme.sh and write the following lines:

```
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/.."
# defines the location where the pm project is located

source "$script_dir/configs/configs.sh"
# loads variables from pm/configs/configs.sh

# some variables that were loaded from configs.sh:
# projects_root_path="/codetemp"
# readme_file='other/readme.md'


family_name=$1
project_name=$2

# family_name and project_name are passed to each option call (for projects)
# in the case of creating a family, only family_name is transmitted


project="$projects_root_path/$family_name/$project_name"
# project path

echo -e "${GREEN}O-> creating readme file${RESET}"
# small notification about the start of the option
# it's cool when a lot of things are displayed in the terminal, right?

cp "$scipt_dir/$readme_file" "$project"
# Finally, let's copy our readme file
```
> Please note that the option script is called readme.sh, but when selecting options you must write readme (.sh part is delivered automatically)


# Tricks

#### You can create a project/family on existing ones to apply new options.
#### You can create "meta" options -- (see pyhon) where you will call several other options.
#### You can still connect to your family using su
(or pm-go with any project name)
#### You may need to change the default tmux config to make it work correctly with true-color (I use alacritty, so my config supports alacritty)
```
set -g default-terminal "alacritty" 
set-option -sa terminal-overrides ",alacritty*:Tc" 
```

# PS
> If this script receives updates, it will most likely be some more specific flags (like --git for cloning a repository) or various strange places will be corrected (like putting .sh when calling options)

