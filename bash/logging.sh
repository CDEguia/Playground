#!/usr/bin/env bash

#############################################################
# Adds verbosity options to a bash script
#
# Minimal Setup, add the following into your script:
#   while getopts "$OPTS" opt; do
#   	handle_verbosity_opts "$opt" "$OPTARG"
#
# Usage:
# .log [LEVEL] [MESSAGE]
#
# Examples:
# .log 1 "Displays an 'alert'"
# .log "alert" "Also displays an 'alert'"
#############################################################
SOURCE=$( dirname -- "${BASH_SOURCE[0]}" )
source "$SOURCE/colorize.sh"

OPTS="v"
__VERBOSE=3

verbosity_usage(){
    echo "  Verbosity options:"
    echo "    -v[v[v][v]]  Default to 'emerg', 'alert', 'crit', 'err'"
	echo "                 Other levels are 'warning', 'notice', 'info', 'debug'"
}

handle_verbosity_opts(){
    case "$1" in
        v) (( __VERBOSE+=1 )) ;;
    esac
}

__usage(){
	echo "    USAGE: .log [[0-1] | [${!KEYWORD_LEVELS[@]}]] 'message'"
}

function __print () {
	declare -A LEVEL_COLORS=(["emerg"]=$RED ["alert"]=$YELLOW ["crit"]="$BLUE" ["err"]=$MAGENTA ["warning"]=$CYAN ["notice"]=$GREEN ["info"]=$GREEN ["debug"]=$RESET)
	local level=$1
	local msg=$2
	printf "${LEVEL_COLORS["$level"]}%-7s %-2s %-50s\n$RESET" "${level^^}" "-" "$msg"
}

function .log () {
	###########################################
	# Print log if level is less or equal to "log level"
	# Default log level in 3(err)
	# 
	# .log [LEVEL] [MESSAGE]
	###########################################
	declare -A KEYWORD_LEVELS
  	# https://en.wikipedia.org/wiki/Syslog#Severity_level
  	KEYWORD_LEVELS=(["emerg"]=0 ["alert"]=1 ["crit"]=2 ["err"]=3 ["warning"]=4 ["notice"]=5 ["info"]=6 ["debug"]=7)
  	
	if [ "$#" -lt 2 ]; then
		__print "warning" "You must provide exactly 2 arguments"
		__usage
	fi
	
	local LEVEL=$1
	
	# Check if input is a number in the set
	if [[ "$LEVEL" =~ ^[0-7]$ ]];then
		local INPUT_LEVEL=$LEVEL
		for key in "${!KEYWORD_LEVELS[@]}"; do
        	if [[ "${KEYWORD_LEVELS[$key]}" == "$INPUT_LEVEL" ]]; then
        	    local LEVEL_TEXT="$key"
        	fi
    	done
	# Check if input if a word in the set
	elif [[ -v KEYWORD_LEVELS["$LEVEL"] ]]; then
		INPUT_LEVEL=${KEYWORD_LEVELS["$LEVEL"]}
		LEVEL_TEXT="$LEVEL"
	# Return if input is not in set
	else
		__print "warning" "Unknown .log LEVEL: '${LEVEL}'"
		__usage
		return
	fi

  	if ((INPUT_LEVEL <= __VERBOSE)); then
  	  shift
  	  __print "$LEVEL_TEXT" "$@"
  	fi
}
