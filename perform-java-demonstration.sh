#!/bin/bash

PROJECTDIR=$(pwd)

# The purpose of this demonstration is to show basic
# usage of git so beginners can get started.
#
# The demonstration project is built using Java
#
# This script may serve as a roadmap to port to Windows
# PowerShell or command-prompt.


# Setup
#      1. Create a GitHub.com repo
#      2. Clone the repo
#      3. Supply this script with the cloned repo

# The final repository will have the following nodes
#
#      0 - 1 - 2 - 3 -  5
#                  \ 4 /
#

# Sanity checks
if [ $# -ne 1 ]; then
    printf "Usage: %s path/to/repo\n" ${0##*/} > /dev/stderr
    exit 1;
fi

introduction(){
    clear
    printf "Welcome to Matt\'s git demonstration\n"
    read enter
}

first_commit(){
    clear
    printf "The initial commit is often some setup\n"
    printf "\nIn this step, we might create these files:\n"
    printf "\t1. README.md\n"
    printf "\t2. .gitignore\n"
    printf "\t3. Ensure that our name and email is configured in our\n"
    printf ".gitconfig\n"
    printf "\tExample: git config --global user.name \"Jim Demo\"\n"
    printf "\t         git config --global user.email \"jim.demo@example.com\"\n"
    printf "\t4. Create a LICENSE (optional)\n"
    cp ${PROJECTDIR}/.gitignore ${PROJECTDIR}/LICENSE ${PROJECTDIR}/README.md .
    printf "$ git status\n"
    git status
    read enter # pause until user enters
    printf "Those files have been created\n"
    sleep 1
    printf "$ git add .gitignore LICENSE README.md\n"
    sleep 1
    git add .gitignore LICENSE README.md
    printf "$ git commit -m \"Initial commit\"\n"
    sleep 1
    printf "$ git push\n\n"
    sleep 1
    printf "$ git log\n"
    git log
    read enter # pause for user enter
}

next_commits(){
    FILEPREFIX=${1}
    clear
    printf "Create and edit files\n"
    sleep 1
    for item in ${PROJECTDIR}/java/${FILEPREFIX}_*.java; do
	# trim file path
	destination=${item##*/}
	# trim the prefix
	destination=${destination##${FILEPREFIX}_}
	cp "${item}" "${destination}"
    done
    printf "$ git status\n"
    git status
    read enter # pause until user enters
    printf "$ git add \*.java\n"
    git add *.java
    commit_message=$(cat ${PROJECTDIR}/java/${FILEPREFIX}_commit_message.txt)
    printf "$ git commit -m \"%s\"\n" "${commit_message}"
    git commit -m "${commit_message}"
    sleep 1
    printf "$ git push\n\n"
    git push
    read enter # pause for user enter
}

branch_commit(){
    FILEPREFIX=${1}
    clear
    printf "For testing (or other purposes), we will create a branch\n"
    printf "\nIn our demonstration, the project is testing\n"
    printf "\na threaded Singer\n"
    sleep 1
    printf "$ git branch threaded\n"
    git branch threaded
    sleep 1
    printf "The branch has been created but we need to switch to it\n"
    printf "$ git checkout threaded\n"
    git checkout threaded
    printf "To display branches, just call \"git branch\" without arguments\n"
    git branch
    read enter # pause until user enters
    printf "Make changes and test it\n"
    printf "You can commit as many changes as needed\n"
    sleep 1
    for item in ${PROJECTDIR}/java/${FILEPREFIX}_*.java; do
	# trim the file path
	destination=${item##*/}
	# trim the prefix
	destination=${destination##${FILEPREFIX}_}
	cp "${item}" "${destination}"
    done
    printf "$ git status\n"
    git status
    read enter # pause until user enters
    printf "$ git add \*.java\n"
    git add *.java
    sleep 1
    commit_message=$(cat ${PROJECTDIR}/java/${FILEPREFIX}_commit_message.txt)
    printf "$ git commit -m \"%s\"\n" "${commit_message}"
    git commit -m "${commit_message}"
    sleep 1
    printf "To have remote track this branch, be sure to push it like this\n"
    printf "This is only required on the first push. Later pushes can be as before\n"
    printf "$ git push --set-upstream origin threaded\n\n"
    git push --set-upstream origin threaded
    read enter # pause for user enter
}

merge_branch(){
    clear
    printf "If you are done with a branch and want to merge\n"
    printf "one branch with another\n"
    printf "Switch branches to the destination\n"
    sleep 1
    printf "$ git checkout main\n"
    git checkout main
    printf "$ git branch\n"
    git branch
    read enter # pause until user hits enter
    printf "This may require an OK from a project leader\n"
    printf "if this is a group project\n"
    sleep 1
    printf "$ git merge threaded\n"
    printf "$ git commit -m \"Merged branches\"\n"
    git commit -m "Merged branches"
    sleep 1
    printf "If the merge was successful, you may delete the branch\n"
    printf "$ git branch -d threaded\n"
    git branch -d threaded
    sleep 1
    read enter # pause for user enter
}

commit_last(){
    clear
    printf "The project wants to accept a user argument from the command-line\n"
    printf "The team tests the change and commits it\n"
    for item in ${PROJECTDIR}/java/5_*.java; do
	# trim the filepath
	destination=${item##*/}
	# trim the prefix
	destination=${destination##5_}
	cp "${item}" "${destination}"
    done
    printf "$ git add \*.java\n"
    git add *.java
    sleep 1
    commit_message=$(cat ${PROJECTDIR}/java/5_commit_message.txt)
    printf "$ git commit -m \"%s\"\n" "${commit_message}"
    git commit -m "${commit_message}"
    printf "$ git push\n"
    git push
    git log
    read enter # pause for user enter
}
    

if [ -d ${1} ]; then
    # if the repository was correctly supplied, change directories
    cd ${1}
    if [ -d .git ]; then
	# if the folder is a git repository, proceed
	first_commit
	for i in {0..3..1}; do
	    next_commits ${i}
	done
	branch_commit 4
	merge_branch
	commit_last
    else
	printf ".git/ does not exist. Is this a repository\?\n" > /dev/stderr
	exit 1
    fi
else
    printf "\"%s\" is not a directory. Exiting\n" ${1} > /dev/stderr
    exit 1
fi
