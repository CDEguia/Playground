#!/bin/bash

#########################################
# Used to easily change the color of test in bash/sh
#
# Import:
#
# SOURCE=$( dirname -- "${BASH_SOURCE[0]}" )
# source "$SOURCE/colorize.sh"
#
# Usage:
# 
# echo -e "${RED}This is red text${RESET}"
#
## Print bold red text
# echo -e "${RED}${BOLD}This is bold red text${RESET}"
#
## Print underlined green text
# echo -e "${GREEN}${UNDERLINED}This is underlined green text${RESET}"
#
#########################################

# Define color codes
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

BOLD='\033[1m'
UNDERLINED='\033[4m'

RESET='\033[0;0m'  # No Color

