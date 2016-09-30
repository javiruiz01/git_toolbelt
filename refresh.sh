#! /bin/bash

MY_PATH=$1
echo "Refreshing"
cd $MY_PATH
echo `pwd`

echo "Do you want to refresh your UPSTREAM? [y/n]"

read answer

if [ $answer == "y" ]
then
	echo "GIT FETCH UPSTREAM"
	git fetch upstream
	if [ $? -eq 0 ]
	then
		echo "GIT CHECKOUT MASTER"
		git checkout master
		if [ $? -eq 0 ]
		then
			echo "GIT MERGE UPSTREAM/MASTER"
			git merge upstream/master
		fi
	fi
fi

echo "Do you want to commit? [y/n]"

read commit_answer

if [ $commit_answer == "y" ]
then
	echo "Input your commit:"
	read commitmssg
	echo "Adding folder"
	git add .
	echo "Making commit"
	git commit -m '"'"$commitmssg"'"'
	echo "Do you want to pusheen? [y/n]"
	read pusheen
	if [ $pusheen == "y" ]
	then
		git push origin master
	fi
fi

echo "Exiting"
exit 0

