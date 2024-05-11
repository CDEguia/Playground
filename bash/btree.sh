#!/usr/bin/env bash

############################################
#
# Output shall be identical to running `tree`
#
############################################
DEBUG=${DEBUG:=false}
if $DEBUG; then
	set -x
fi
SOURCE=$( dirname -- "${BASH_SOURCE[0]}" )
source "$SOURCE/logging.sh"

shopt -s nullglob

# Hardcode vars
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

FILE='FILE'
DIR='DIR'
EXE='EXE'

# Global counters
total_directory_count=0
total_file_count=0
current_item_color=
current_item_type=
temp_frame=""

update_frame(){
	local is_last_dir=$1
	if $is_last_dir; then
		temp_frame="$temp_frame    "
	else
		temp_frame="$temp_frame\U2502   "
	fi
}

print_frame(){
	local level=$1
	local current_count=$2
	local total_count=$3
	local string=""

	if (( current_count == total_count )) ; then
		string="$temp_frame\U2514"
	else
		string="$temp_frame\U251C"
	fi
	string="$string\U2500\U2500 "
	echo -en "$NC$string"
}

set_current_item_info(){
	file_path=$1
	if [ -d "$file_path" ]; then
		current_item_type=$DIR
		current_item_color=$BLUE # color for directories
	elif [ -x "$file_path" ]; then
		current_item_type=$EXE
		current_item_color=$GREEN # color for executalbes
	else
		current_item_type=$FILE
		current_item_color=$NC # no color for other files
	fi
}

tree(){
	local level=${2:-0}
	local count_at_level=0
	local current_count=0
	local is_last_in_dir=${3:-false}
	local update_frame=true
	for f in $1 ; do
		((count_at_level++))
	done
	.log "debug" "$@"
	if ((count_at_level==0)); then
		# Add space to compensate for the blind removal of after the return to the calling function without going through the next loop 
		update_frame $update_frame
	fi
	for f in $1 ; do
		((current_count++))
		if ((level != 0)); then
			if $update_frame && ((level != 1)); then
				update_frame $is_last_in_dir
				update_frame=false
			fi
			print_frame $level $current_count $count_at_level $update_frame
		fi
		set_current_item_info "$f"
		echo -e "${current_item_color}${f##*/}${NC}"
		
		if [ "$current_item_type" = "$DIR" ]; then
			((total_directory_count++))
			
			if ((current_count == count_at_level)); then
				is_last_in_dir=true
			else
				is_last_in_dir=false
			fi	
			
			tree "$f/*" $(((++level))) $is_last_in_dir
			if [ "${temp_frame:(-4)}" != '    ' ]; then
				temp_frame=${temp_frame%?????????}
			else
				temp_frame=${temp_frame%????}
			fi
			((level--))
		else
			((total_file_count++))
		fi
	done
}


OPTS="${OPTS}h"

usage(){
	command_name="${0##*/}"
	echo "Usage: $command_name [-${OPTS}] [directory ...]"
	echo
	verbosity_usage
	echo 
	echo "  Specific options:"
	echo "    -h			Show usage"
}

while getopts "$OPTS" opt; do
	handle_verbosity_opts "$opt" "$OPTARG"
    case "$opt" in
		h) usage; exit 0 ;;
		\?) usage; exit 1 ;;
    esac	
done
shift $((OPTIND-1))

starting_dir=${@:-.}
.log debug "dir: $starting_dir"

for d in "$starting_dir"; do
	tree "$d"
	echo
done

echo -e "${NC}\n$total_directory_count directories, $total_file_count files"
