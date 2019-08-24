#!/bin/sh

# Script to configure SwiftLint
# For execution, use the ‘bash hooksSetup.sh’ command

# The following elements should be installed during startup:
# 1) Add `.swiftlint.yml` config file for` SwiftLint`
# 2) The git-hooks folder will become the default folder for git hooks

# Directories
GIT_HOOKS_DIRECTORY=$(pwd)/git-hooks

# -- 1 -- Linking `.swiftLint.yml`
echo "1. Linking .swiftlint.yml:"
ln -sf ../setup/.swiftlint.yml ../zhazam/.swiftlint.yml 

if [[ $? != 0 ]] ; then
echo ".swiftlint.yml moving failed"
else 
echo ".swiftlint.yml moved successfully"
fi

# -- 2 -- Reassigning hooks
echo "2. Reassigning Git Hooks:"
git config core.hooksPath $GIT_HOOKS_DIRECTORY
chmod +x $GIT_HOOKS_DIRECTORY/*
echo "Hooks successfully reassigned to '$GIT_HOOKS_DIRECTORY'"
