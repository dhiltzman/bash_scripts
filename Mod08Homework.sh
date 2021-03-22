#! /bin/bash

#Mod 08 Homework
#Author: David Hiltzman

#I wrote a quick if statement that sees if a directory is present
#NOTE: MAKE SURE THE PCAP FILE IS IN THIS DIRECTORY OR IT WILL FAIL.
dircheck=~/bash_scripts/mod08h

if ! [[ -d $dircheck ]];then
	mkdir ~/bash_scripts/mod08h
fi

clear

#Writing an array for each line to be prepped for output
#lineComplete=()

#destructive on purpose 
echo "Date,Time,Priority,Classification,Description,SourceIP,DestinationIP" > ~/bash_scripts/mod08h/alert_data.csv

#adding what file we are reading
input=~/bash_scripts/mod08h/fast_short.pcap

echo -e "Processing the pcap file..\n"
echo -e "Grab a beer or something..\n"

#The good stuff right here
#This breaks each line up into the needed variables, then puts them back together 
#lineBar is the final iteration that has the underscores and } fixed to the right translations

while IFS= read -r line
do
	lineUnderscore=$(echo $line | tr " " "_")
	lineBar=$(echo $lineUnderscore | tr "}" "|")

	#Found the Date
	date=$(echo $lineUnderscore | cut -d "-" -f1)
	
	#used secondCut to find time
	secondCut=$(echo $lineUnderscore | cut -d "-" -f2)
	time=$(echo $secondCut | cut -d "_" -f1)
	
	#Found everything else from lineBar
	#I then clean it up by getting rid of the underscores
	#I did the same thing for each one
	#I am only explaining this one
	#Rinse and repeat for each other one
	description=$(echo $lineBar | cut -d "]" -f3)
	description=$(echo $description | tr "_" " ")
	description=$(echo $description | cut -d "[" -f1)

	classification=$(echo $lineBar | cut -d ":" -f6)
	classification=$(echo $classification | cut -d "]" -f1)
	classification=$(echo $classification | tr "_" " ")

	priority=$(echo $lineBar | cut -d ":" -f7)
	priority=$(echo $priority | cut -d "]" -f1)\
	priority=$(echo $priority | tr "_" " ")
	priority=$(echo $priority | cut -d " " -f2) 

	sourceIP=$(echo $lineBar | cut -d "|" -f2)
	sourceIP=$(echo $sourceIP | cut -d "-" -f1)
	sourceIP=$(echo $sourceIP | cut -d "_" -f2) 

	destIP=$(echo $lineBar | cut -d "|" -f2)
	destIP=$(echo $destIP | cut -d ">" -f2)
	destIP=$(echo $destIP | cut -d "_" -f2)

	#Combined all the variables into something that can be read by a csv
	lineOutput="$date,$time,$priority,$classification,$description,$sourceIP,$destIP"
	#echo "$lineOutput"

	#outputs to the CSV
	echo $lineOutput >> ~/bash_scripts/mod08h/alert_data.csv

done < $input

#wraps up the program
clear
echo -e "The pcap file has been processed.\n"

#Enjoy!
