#!/bin/bash
#make some variables
EXPECTED_OUTPUT=$1
ACTUAL_OUTPUT=$2
EXCVar=$(cat $EXPECTED_OUTPUT)

#retrieve the filename from arguments
#use while loop to read in names via redirection
while read STUDENTKEY; do
	SCORE=0
	git clone https://github.com/CSE2307SP26/$STUDENTKEY.git
	cd $STUDENTKEY
	git checkout cipher
	git rev-list -n 1 --before="2026-02-12 10:00:00 -0600" cipher 
	javac Cipher.java #complies it
	java Cipher #runs the code

	if [[ -f "$ACTUAL_OUTPUT" ]]
	then
		OUTVar=$(cat $ACTUAL_OUTPUT)
		if [[ $OUTVar = $EXCVar ]]
		then
			SCORE=1
		else
			SCORE=0
		fi
	else
		SCORE=0
	fi
		echo "$STUDENTKEY : $SCORE"
	git checkout main
	cd ..
done
