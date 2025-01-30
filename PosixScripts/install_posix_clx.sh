#/bin/sh

__Dir__="$(dirname "$(realpath "$0")")"
# these NEED to be, maybe set them with a Makefile?
# keep in mind, this is an install script
# should be ran once or few
__Fns__="${__Dir__}/functions"
__Fns_Global__="${__Dir__}/functions/global"

# $? return value, non zero is error
. "${__Dir__}/functions/global/Vars"

for file in ${__Fns_Global__}/*;
do
	# shellcheck disable=SC1090
	printf "importing file: %s\n" "$file";
	# check if file exist here
	. "$file"
done;

CheckOS
printf "%s$" "${__OS__}"

