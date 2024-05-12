#!/usr/bin/env bash

# Adds verbosity options to a bash script
#
# Minimal Setup, add the following into your script:
#   while getopts "$OPTS" opt; do
#   	handle_verbosity_opts "$opt" "$OPTARG"
#
# Usage:
# .log [LEVEL] [MESSAGE]

OPTS="v"
__VERBOSE=3

verbosity_usage(){
    echo "  Verbosity options:"
    echo "    -v[v[v]]     Be verbose"
}

handle_verbosity_opts(){
    case "$1" in
        v) (( __VERBOSE+=1 )) ;;
    esac
}

function .log () {
	declare -A KEYWORD_LEVELS
  	# https://en.wikipedia.org/wiki/Syslog#Severity_level
  	KEYWORD_LEVELS=(["emerg"]=0 ["alert"]=1 ["crit"]=2 ["err"]=3 ["warning"]=4 ["notice"]=5 ["info"]=6 ["debug"]=7)
  	local LEVEL=$1
  	if ((__VERBOSE >= KEYWORD_LEVELS[$LEVEL])); then
  	  shift
  	  echo "[${LEVEL}]" "$@"
  	fi
}
