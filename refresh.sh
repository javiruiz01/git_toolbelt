#! /bin/bash

MY_PATH=$1
echo "Refreshing"
cd $MY_PATH
echo `pwd`

echo "Do you want to refresh your UPSTREAM? [Y/n]"

read  answer

if [ $answer == "n" ]
then
	echo "Next question then"
else
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

echo "Do you want to commit? [Y/n]"

read commit_answer

if [ $commit_answer == "n" ]
then
	echo "We're done here"
else
	echo "Input your commit:"
	read commitmssg
	echo "Adding folder"
	git add .
	echo "Making commit"
	git commit -m "$commitmssg"
	echo "Do you want to pusheen? [y/N]"
	read pusheen
	if [ $pusheen == "y" ]
	then
		git push origin master
	fi
fi

echo "Exiting"
exit 0

