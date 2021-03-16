#! /bin/bash
#Mod 07 Homework
#Author: David Hiltzman

name_array=('Constance_Castillo' 'Kerry_Goodwin' 'Dorothy_Carson' 'Craig_Williams' 
'Daryl_Guzman' 'Sherman_Stewart' 'Marvin_Collier' 'Javier_Wilkerson' 'Lena_Olson' 
'Claudia_George' 'Erik_Elliott' 'Traci_Peters' 'Jack_Burke' 'Jody_Turner' 'Kristy_Jenkins' 
'Melissa_Griffin' 'Shelia_Ballard' 'Armando_Weaver' 'Elsie_Fitzgerald' 'Ben_Evans' 'Lucy_Baker' 
'Kerry_Anderson' 'Kendra_Tran' 'Arnold_Wells' 'Anita_Aguilar' 'Earnest_Reeves' 'Irving_Stone' 
'Alice_Moore' 'Leigh_Parsons' 'Mandy_Perez' 'Rolando_Paul' 'Delores_Pierce' 'Zachary_Webster' 
'Eddie_Ward' 'Alvin_Soto' 'Ross_Welch' 'Tanya_Padilla' 'Rachel_Logan' 'Angelica_Richards' 
'Shelley_Lucas' 'Alison_Porter' 'Lionel_Buchanan' 'Luis_Norman' 'Milton_Robinson' 'Ervin_Bryant' 
'Tabitha_Reid' 'Randal_Graves' 'Calvin_Murphy' 'Blanca_Bell' 'Dean_Walters' 'Elias_Klein' 
'Madeline_White' 'Marty_Lewis' 'Beatrice_Santiago' 'Willis_Tucker' 'Diane_Lloyd' 'Al_Harrison' 
'Barbara_Lawson' 'Jamie_Page' 'Conrad_Reynolds' 'Darnell_Goodman' 'Derrick_Mckenzie' 
'Erika_Miller' 'Tasha_Todd' 'Aaron_Nunez' 'Julio_Gomez' 'Tommie_Hunter' 'Darlene_Russell' 
'Monica_Abbott' 'Cassandra_Vargas' 'Gail_Obrien' 'Doug_Morales' 'Ian_James' 'Jean_Moran' 
'Carla_Ross' 'Marjorie_Hanson' 'Clark_Sullivan' 'Rick_Torres' 'Byron_Hardy' 'Ken_Chandler' 
'Brendan_Carr' 'Richard_Francis' 'Tyler_Mitchell' 'Edwin_Stevens' 'Paul_Santos' 
'Jesus_Griffith' 'Maggie_Maldonado' 'Isaac_Allen' 'Vanessa_Thompson' 'Jeremy_Barton' 
'Joey_Butler' 'Randy_Holmes' 'Loretta_Pittman' 'Essie_Johnston' 'Felix_Weber' 'Gary_Hawkins' 
'Vivian_Bowers' 'Dennis_Jefferson' 'Dale_Arnold' 'Joseph_Christensen' 'Billie_Norton' 
'Darla_Pope' 'Tommie_Dixon' 'Toby_Beck' 'Jodi_Payne' 'Marjorie_Lowe' 'Fernando_Ballard' 
'Jesse_Maldonado' 'Elsa_Burke' 'Jeanne_Vargas' 'Alton_Francis' 'Donald_Mitchell' 'Dianna_Perry' 
'Kristi_Stephens' 'Virgil_Goodwin' 'Edmund_Newton' 'Luther_Huff' 'Hannah_Anderson' 'Emmett_Gill' 
'Clayton_Wallace' 'Tracy_Mendez' 'Connie_Reeves' 'Jeanette_Hansen' 'Carole_Fox' 'Carmen_Fowler' 
'Alex_Diaz' 'Rick_Waters' 'Willis_Warren' 'Krista_Ferguson' 'Debra_Russell' 'Ellis_Christensen' 
'Freda_Johnston' 'Janis_Carpenter' 'Rosemary_Sherman' 'Earnest_Peters' 'Kelly_West' 
'Jorge_Caldwell' 'Moses_Norris' 'Erica_Riley' 'Ray_Gordon' 'Abel_Poole' 'Cary_Boone' 
'Grant_Gomez' 'Denise_Chapman' 'Vernon_Moran' 'Ben_Walker' 'Francis_Benson' 'Andrea_Sullivan' 
'Wayne_Rice' 'Jamie_Mason' 'Jane_Figueroa' 'Pat_Wade' 'Rudy_Bates' 'Clyde_Harris' 'Andre_Mathis' 
'Carlton_Oliver' 'Merle_Lee' 'Amber_Wright' 'Russell_Becker' 'Natalie_Wheeler' 'Maryann_Miller' 
'Lucia_Byrd' 'Jenny_Zimmerman' 'Kari_Mccarthy' 'Jeannette_Cain' 'Ian_Walsh' 'Herman_Martin' 
'Ginger_Farmer' 'Catherine_Williamson' 'Lorena_Henderson' 'Molly_Watkins' 'Sherman_Ford' 
'Adam_Gross' 'Alfred_Padilla' 'Dwayne_Gibson' 'Shawn_Hall' 'Anthony_Rios' 'Kelly_Thomas' 
'Allan_Owens' 'Duane_Malone' 'Chris_George' 'Dana_Holt' 'Muriel_Santiago' 'Shelley_Osborne' 
'Clinton_Ross' 'Kelley_Parsons' 'Sophia_Lewis' 'Sylvia_Cooper' 'Regina_Aguilar' 
'Sheila_Castillo' 'Sheri_Mcdonald' 'Lynn_Hodges' 'Patrick_Medina' 'Arlene_Tate' 'Minnie_Weber' 
'Geneva_Pena' 'Byron_Collier' 'Veronica_Higgins' 'Leo_Roy' 'Nelson_Lopez')

#Adding spaces to everything
name_string=$(echo ${name_array[*]} | tr "_" " ")

#converting to all lowercase
name_string=$(echo ${name_string[*]} | tr [:upper:] [:lower:])

first_name(){
	length=${#name_array[*]}

	read -p "Enter the first name, or a partial start of the first name: " userNameSearch
	echo -e "You have chosen: $userNameSearch\n"
	
	if [[ $userNameSearch == "" ]];then
		output=$(echo $name_string[*] | sed's/|/\\n/g')
		echo -e "Nothing was entered"
		echo -e ${name_string[*]}
		#read -p "continue"
	fi
	
	userNameSearch=$(echo $userNameSearch | tr [:upper:] [:lower:])
	#userName_initial=$(echo $(userNameSearch:0:1) | tr [:lower:] [:upper:])
	#userName_remaining=$(userNameSearch:1)
	#userNameSearch="$userName_initial$userName_remaining"	

	for i in ${#name_string[*]};
	do
		if [[ ${name_string[$i]} == *$userNameSearch* ]]; then
			read -p "continue"
			echo -e "$name_array[i]"
			break
		else
			echo "No matches"
		fi
	done

}

delete_name(){
	read -p "Please enter a full name to delete: " removeName
	echo -e "You have selected $removeName\n"
	
	removeName=$( echo $removeName | tr " " "_")

	echo -e "$removeName\n"

	for i in ${name_array[*]};
	do
		if [[ ${name_array[$i]} == *$removeName* ]];then
			name_array=(${name_array[*]:0:$i} ${name_array[*]:$(($i + 1))})
			name_string=(${name_string[*]:0:$i} ${name_string[*]:$(($i + 1))})
			echo "Delete Complete"
			break
		else
			echo -e "Something failed, please try again.\n"
			read
		fi
	done

}
#Main Function
while true;
do
	clear
	echo -e "Please select from the following options:\n
\t1. List all names starting with one or more letters of the first name
\t2. List all names starting with one or more letters of the last name
\t3. Add a name
\t4. Delete a name
\t5. Exit \n"

	read -p "Option # " userInput

	echo -e "You have chosen $userInput"
	
	#Going to do an if/elif/else statement to check functions
	if [[ $userInput == 1 ]]; then
		echo -e "FirstNames\n"
		first_name
	elif [[ $userInput == 2 ]]; then
		echo -e "LastName\n"
	elif [[ $userInput == 3 ]]; then
		echo -e "AddName\n"
	elif [[ $userInput == 4 ]]; then
		echo -e "DeleteName\n"
		delete_name
	elif [[ $userInput == 5 ]]; then
		read -p "Press Enter to leave."
		break
	else
		echo -e "Something went wrong, please try again."
	fi
done
