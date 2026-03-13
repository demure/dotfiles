#!/bin/bash

## Script to do a basic level setup of my dotfiles into $HOME.
## Mostly covering the CLI essentials


## Grab current dir
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PARENT_DIR=$( echo ${SCRIPT_DIR} | awk -F'/' 'BEGIN{OFS=FS} {$NF=""; print}' | sed 's/\/$//' )


## Prevent running as root for safety
if [ ${UID} == 0 ]; then
    echo "Do not run this as root."
    exit 2
fi


## Prep the config and override dir
mkdir -p $HOME/.config
mkdir -p $HOME/.config/dotconf


## Link configs into place
if [ -d ${PARENT_DIR}/.git  ]; then
    confs=( inputrc vimrc subbash bashrc )
    for c in "${confs[@]}"; do
        ln -sf ${PARENT_DIR}/${c} ${HOME}/.${c}
    done

    ln -sf ${PARENT_DIR}/bashrc ${HOME}/.bash_login

    confs=( tmux )
    for c in "${confs[@]}"; do
        ln -sf ${PARENT_DIR}/config/${c} ${HOME}/.config/${c}
    done
else
    echo "No .git found in ${PARENT_DIR} . Have you moved the install script?"
    exit 2
fi


## Notes on manual next steps
echo -e "You will want to manually:\n\t* Run vim to get plugins\n\t* add ~/.config/dotconf files\n\t* ssh config"
