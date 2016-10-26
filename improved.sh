#! /bin/bash

function commit {
	echo "I'm in the commit function"
	echo "Input your commit"
	read commitmssg
	echo "Adding folder"
	git add .
	echo "Making commit"
	git commit -m "$commitmssg"
	return 0
}

function upstream {
	echo "Refreshing the UPSTREAM"
	git fetch upstream
	if [[ $? -eq 0 ]]
	then
		echo "GIT CHECKOUT MASTER"
		git checkout master
		if [[ $? -eq 0 ]]
		then
			echo "GIT MERGE UPSTREAM/MASTER"
			git merge upstream/master
		fi
	fi
	return
}

function pusheen {
	echo "I'm in the pusheen function"
	git push origin master
	return
}

function print_usage() {
	printf "\e[31mUsage:\e[0m `basename $0` [OPTIONS]\n"
	printf "\e[32mOPTIONS:\e[0m\n"
	printf "	-p		Push to master\n"
	printf "	-c 		Commit\n"
	printf "	-u		Refresh upstream\n"
	printf "			Must already be set\n"
	printf "	-h 		Display usage\n"
	printf "	-f path		Add path to repository\n"
	printf "\e[32mEXAMPLE:\e[0m\n"
	printf "	$0 -f /path/to/file -c\n"
	printf "\e[7m|------------------------------------------------|\e[0m\n"
	echo "If you don't want to use the options,"
	echo "please use the \e[32mrefresh.sh\e[0m script"
	return
}

function main {
	echo "$@"
	if [[ $# -eq 0 ]]
	then
		print_usage
	fi

	while getopts ":pcuhf:" opt
	do
		case $opt in
			c)
				echo "I should do a commit"
				commit
				;;
			\?)
				echo "Unknown option: -$OPTARG"
				;;
			p)
				echo "I should do a PUSHEEN"
				pusheen
				;;
			u)
				echo "I should update the UPSTREAM"
				upstream
				;;
			h)
				echo "I should go help you"
				print_usage
				;;
			f)	echo "Following PATH"
				my_path=$OPTARG
				cd $my_path
				echo `pwd`		
				;;
		esac
	done
}

main "$@"

echo "Exiting"
exit 0
