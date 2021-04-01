#! /bin/sh

#Project 2
#Author: David Hiltzman

major_descriptors="BAD-TRAFFIC,DNS SPOOF,ET CURRENT_EVENTS,ET DNS,ET INFO,ET MALWARE,ET POLICY,ET TROJAN,ET WEB_CLIENT,ICMP,INFO,SCAN,WEB-IIS"
major_descriptors=$(echo $major_descriptors | tr " " "_")

#creating an array for the split up descriptors to be in
declare -a mjd_array=()

declare -a tuples_match=()

#DirCheck
zipcheck=~/bash_scripts/alert_full_short.pcap.tgz
filecheck=~/bash_scripts/alert_full_short_cleaned.csv

parse_data(){
	clear

	#Parsing the data here
	#unzipped
	echo -e "Please be patient. Parsing Data...\n"
	tar -xzf alert_full_short.pcap.tgz
	
	#destructive on purpose
	echo "Date,Time,Priority,Classification,Description,Packet Type,Source IP, Source Port,Destination IP, Destination Port" > ~/bash_scripts/alert_full_short_cleaned.csv
	
	input=~/bash_scripts/alert_full_short.pcap

	while IFS= read -r line
	do
		first_line_cut=$(echo $line | tr " " "_")
		
		#First Line
		#Finding Description
		if [[ ${line:0:4} == "[**]" ]];then
			#echo -e "$first_line_cut\n"
			description=$(echo $first_line_cut | cut -d "]" -f3)
			description=$(echo $description | cut -d "[" -f1)
			description=$(echo ${description:1})
		#Second Line
		#Classification and Priority
		elif [[ ${line:0:16} == "[Classification:" ]];then
			classification=$(echo $line | tr " " "_")
			classification=$(echo $classification | cut -d ":" -f2)
			classification=$(echo $classification | cut -d "]" -f1)
			classification=$(echo ${classification:1})

			priority=$(echo $line | tr " " "_")
			priority=$(echo $priority | cut -d "]" -f2)
			priority=$(echo $priority | cut -d "_" -f3)
		
		#Third Line
		#Date,Time, IPs
		#If not port is found, it says "unspecified"
		elif [[ ${line:2:1} == "/" ]];then
			date=$(echo $line | tr " " "_")
			date=$(echo $date | cut -d "-" -f1)

			time=$(echo $line | tr " " "_")
			time=$(echo $time | cut -d "-" -f2)
			time=$(echo $time | cut -d "_" -f1)

			source_ip=$(echo $line | tr " " "_")
			source_ip=$(echo $source_ip | cut -d "_" -f2)
			if [[ $source_ip == *":"* ]];then
				source_port=$(echo $source_ip | cut -d ":" -f2)
				source_ip=$(echo $source_ip | cut -d ":" -f1)
			else
				source_port="unspecified"
			fi

			dest_ip=$(echo $line | tr " " "_")
			dest_ip=$(echo $dest_ip | cut -d "_" -f4)

			if [[ $dest_ip == *":"* ]];then
				dest_port=$(echo $dest_ip | cut -d ":" -f2)
				dest_ip=$(echo $dest_ip | cut -d ":" -f1)
			else
				dest_port="unspecified"
			fi

		#A real gross way of finding the packet,
		elif [[ ${line:0:3} == "UDP" || ${line:0:3} == "TCP" || ${line:0:4} == "ICMP" ]];then
			packet_type=$(echo $line | tr " " "_")
			packet_type=$(echo $packet_type | cut -d "_" -f1)
			#echo -e "$packet_type\n"

		#checks for a blank line
		#if found, appends all the data gathered and sends it to the csv.
		elif [[ $line == "" ]];then
			line_output="$date,$time,$priority,$classification,$description,$packet_type,$source_ip,$source_port,$dest_ip,$dest_port"

			#appends csv
			echo $line_output >> ~/bash_scripts/alert_full_short_cleaned.csv
		fi

	done < $input	

	echo -e "Parsing Complete"
	read -p "Press Enter to return to the menu."
}

major_descriptors(){
	#checking to see if the csv file is available. If not, returns to menu.
	clear
	if ! [[ -f $filecheck ]];then
		echo -e "Parse alert data first using choice 1 from the main menu."
		read -p "Press Enter to return to the menu."
		return
	fi

	#While loop that checks for user_input then compares it to the major descriptors
	while true;
	do
		clear
		#Tuples_matches is where the matches of descriptors go if found
		tuple_matches=()
		#Description_matches_found puts all the entries that match the input
		description_matches_found=()

		echo -e "Enter one or more starting characters for your major descriptor, or
Enter nothing to see all major descriptors, or
Enter 'exit' to return to the main menu.\n"
		read -p "Enter your selection: " user_input

		echo -e "You have input $user_input\n"
		#Converted to uppercase to make it easier to view
		user_input=$(echo $user_input | tr [:lower:] [:upper:])

		#Cheks for Break
		if [[ $user_input == "EXIT" ]];then
			read -p "Press Enter to return to the menu."
			break
		fi

		#moves descriptors to an array for easier searching
		IFS="," read -r -a mjd_array <<< "$major_descriptors"
	
		#Getting length of array
		len_major_const=${#mjd_array[*]}
		
		i=0	

		#Loops to see if the userinput matches anything
		while [[ i -lt len_major_const ]];
		do
			#If one is found, they get added to the array for matches
			if [[ ${mjd_array[i]} == *$user_input* ]];then
				interior_selection=${mjd_array[$i]}
				tuple_matches+="$interior_selection,"			
			fi

			i=$(($i + 1))
			
		done 
		
		#converted to array
		IFS="," read -r -a tuples_array <<< "$tuple_matches"

		tuple_len=${#tuples_array[*]}
	
		#Checks the length of matched descriptors. If not, it starts over, same as more than 1
		#If there is only one match, it reads csv
		if [[ $tuple_len == 0 ]];then
			echo "No Major descriptors were found with those starting characters."
			echo "Please try again."
		elif [[ $tuple_len == 1 ]];then
			#grabs the single input converts
			single_input=${tuples_array[0]}
			output=$(echo $single_input | tr "_" " ")
			
			echo -e "Your Selection is $output\n"

			#Reads CSV to find descriptions that include user_input,
			#if they do, they get put into descriptors match
			input=~/bash_scripts/alert_full_short_cleaned.csv
			
			while IFS= read -r line
			do
				description=$(echo $line | cut -d "," -f5)
				
				if [[ $description == *"$single_input"* ]];then	
					description_matches_found+="$description,"
				fi
			done < $input

		else
			echo -e "More than one Match was found. See below for matches.\n"
			for j in ${tuples_array[*]};
			do
				echo $j
			done
		fi

		#moves matches to an array then checks length for output
		IFS="," read -r -a description_matches_array <<< "$description_matches_found"
		echo -e "There are ${#description_matches_array[*]} Unique Results.\n"
		read -p "Press Enter to continue."
	done
}

classifications(){
	echo -e "This is absolutely HATEFUL to do in Bash. Hard Pass.\n"
	read -p "Press Enter to return to the menu."
}

clean_up(){
	clear
	echo -e "Cleaning up, please wait.\n"
	save_name="$last_name,$first_name"
	save_name=$(echo $save_name | tr "," "_")
	save_name="$save_name.tgz"	

	save_check=~/$save_name

	if [[ -d $save_check ]];then
		rm -r $save_check
	fi
	
	mkdir $save_check
	mv alert_full_short_cleaned.csv $save_check
	mv alert_full_short.pcap $save_check

}

#Name String Setup
MY_NAME="David Hiltzman"
first_name=$(echo $MY_NAME | tr " " "_")
first_name=$(echo $first_name | cut -d "_" -f1)
last_name=$(echo $MY_NAME | tr " " "_")
last_name=$(echo $last_name | cut -d "_" -f2)

if ! [[ -f $zipcheck ]];then
	echo -e "Please put zip file into bash_script directory\n"
	read -p "Press enter to leave the prompt"
	exit
fi

while true;
do
	clear
	echo -e "Welcome to Project 2.\n
Please select from the following options:\n
\t1. Parse Alert Data
\t2. Major Descriptors
\t3. Classifications
\t4. Clean up and exit"
	read -p "Option#: " user_input
	
	echo -e "You have chosen $user_input"

	if [[ $user_input == 1 ]];then
		parse_data
	elif [[ $user_input == 2 ]];then
		major_descriptors
	elif [[ $user_input == 3 ]];then
		classifications
	elif [[ $user_input == 4 ]];then
		clean_up
		read -p "Press Enter to leave."
		break
	else
		echo -e "Something went wrong, please try again."
		read -p "Press Enter to try again."
	fi

done
