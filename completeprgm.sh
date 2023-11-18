#!/bin/bash
clear
figlet -c "Welcome to my Program" | sed 's/./\x1b[31m&\x1b[0m/g'

# List directories in the current location
echo "Directories in the current location:"
ls -l | grep '^d'

# Prompt for the new directory name
read -p "Enter the name of the new directory: " NEW_DIRECTORY_NAME

# Check if the directory name is provided
if [ -z "$NEW_DIRECTORY_NAME" ]; then
    echo "Please provide a name for the new directory."
    exit 1
fi

# Create the new directory
mkdir "$NEW_DIRECTORY_NAME"

# Change into the new directory
cd "$NEW_DIRECTORY_NAME"
clear
../html_create.sh
