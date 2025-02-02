#/bin/sh
cat << HERE
Installing Hyperland Configs and sh*t


HERE

__Dir__="$(dirname "$(realpath "$0")")"
# these NEED to be, maybe set them with a Makefile?
# keep in mind, this is an install script
# should be ran once or few
__Fns__="${__Dir__}/functions"
__Fns_Global__="${__Dir__}/functions/global"

# $? return value, non zero is error
#############################
# Importing		    #
#############################

. "${__Dir__}/functions/global/Vars"
__Global_Count__="$(/bin/ls -l "${__Fns_Global__}" | wc -l)"
if (( ${__Global_Count__} < 9 )); then
	printf "less then expected files in folder\n" 
	printf "aborting ..\n"
	exit 1
fi

for file in ${__Fns_Global__}/*;
do
	if [ -f "$file" ]; then
		# shellcheck disable=SC1090
		printf "importing file: %s\n" "$file";
		# check if file exist here
		. "$file"
	# this branch might be unreachable 
	# check file count before loop in the directory ?
	else
		printf "file doesnt exist:\n" "${file}";
		printf "aborting ..\n"
		exit 1
	fi
done;

####################
# options          #
####################
flg_Install=0
flg_Restore=0
flg_Service=0
flg_DryRun=0
flg_Shell=0
flg_Nvidia=1
flg_ThemeInstall=1

while getopts idrstmnh: RunStep; do
	case $RunStep in
	i)	flg_Install=1 ;;
	d) 
		flg_Install=1
		export use_default="--confirm"
		;;
	r)	flg_Restore=1 ;;
	s)	flg_Service=1 ;;
	n)	
		# shellcheck disable=SC2034
		export flg_Nvidia=0
		PrintLog -r "[nvidia] " -b "Ignored :: " "skipping Nvidia actions"
		;;
	h)
		# shellcheck disable=SC2034
		export flg_Shell=0
		PrintLog -r "[shell] " -b "Reevaluate :: " "shell options"
		;;
	t)	flg_DryRun=1 ;;
	m)	flg_ThemeInstall=0 ;;
	*)	
		cat <<< 'a usefull message?'
		exit 1
		;;
	esac
done

HYDE_LOG="$(date +'%y%m%d_%Hh%Mm%Ss')"
export flg_DryRun flg_Nvidia flg_Shell flg_Install \
	ThemeInstall HYDE_LOG
if [ "${flg_DryRun}" -eq 1 ]; then
	print_log -n "[test-run] " -b "enabled :: " "Testing without executing"

elif [ $OPTIND -eq 1 ]; then
	printf "in here!!!\n"
	flg_Install=1
	flg_Restore=1
	flg_Service=1
fi

#############################
#	pre-install phase   #
#############################

if [ ${flg_Install} -eq 1 ] && [ ${flg_Restore} -eq 1 ]; then
	printf "pre -install script here \n"
fi

PkgInstalledV2 grub



#if ! PkgInstalled bat; then
#	printf "Success!\n"
#else
#	printf "Failure!\n"
#fi
#val="$(PkgInstalledV2 battotakjljlkj)"
#printf "val is: %d\n" "$val"
#if ! [[ $val ]]; then
#	printf "Success!\n"
#else
#	printf "Failure!\n"
#fi
#CheckList 1 2 3 4 5 6
