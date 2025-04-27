#!/bin/bash
#
if [ $# -eq 2 ]
then
    name=$1
    email=$2
else

    echo
    echo "you must provide you name and email for git"
    echo
    echo "> $0 '<name>' <email> "
    echo

    exit 1
fi


git config --global user.name "$name"
git config --global user.email "$email"

git config --global init.defaultBranch main

echo > ~/.gitignore

git config --global core.excludesFile ~/.gitignore

echo .DS_Store >> ~/.gitignore

git config --global core.editor "vim"