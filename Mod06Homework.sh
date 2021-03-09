#! /bin/sh

#declare and fill the four suits for the deck
declare -a spades=('Ace_of_Spades' 'King_of_Spades' \
            'Queen_of_Spades' 'Jack_of_Spades' \
            '10_of_Spades' '9_of_Spades' \
            '8_of_Spades' '7_of_Spades' \
            '6_of_Spades' '5_of_Spades' \
            '4_of_Spades' '3_of_Spades' \
            '2_of_Spades')

declare -a diamonds=('Ace_of_Diamonds' 'King_of_Diamonds' \
            'Queen_of_Diamonds' 'Jack_of_Diamonds' \
            '10_of_Diamonds' '9_of_Diamonds' \
            '8_of_Diamonds' '7_of_Diamonds' \
            '6_of_Diamonds' '5_of_Diamonds' \
            '4_of_Diamonds' '3_of_Diamonds' \
            '2_of_Diamonds')

declare -a clubs=('Ace_of_Clubs' 'King_of_Clubs' \
            'Queen_of_Clubs' 'Jack_of_Clubs' \
            '10_of_Clubs' '9_of_Clubs' \
            '8_of_Clubs' '7_of_Clubs' \
            '6_of_Clubs' '5_of_Clubs' \
            '4_of_Clubs' '3_of_Clubs' \
            '2_of_Clubs')
			
declare -a hearts=('Ace_of_Hearts' 'King_of_Hearts' \
            'Queen_of_Hearts' 'Jack_of_Hearts' \
            '10_of_Hearts' '9_of_Hearts' \
            '8_of_Hearts' '7_of_Hearts' \
            '6_of_Hearts' '5_of_Hearts' \
            '4_of_Hearts' '3_of_Hearts' \
            '2_of_Hearts')

declare -a shuffledSpades=()

declare -a shuffledDiamonds=()

declare -a shuffledClubs=()

declare -a shuffledHearts=()

#Shuffled Cards
new_cards() {
	shuffledSpades=(${spades[*]})
	shuffledDiamonds=(${diamonds[*]})
	shuffledClubs=(${clubs[*]})
	shuffledHearts=(${hearts[*]})

	spades_gone=0
	diamonds_gone=0
	clubs_gone=0
	hearts_gone=0	
	
	echo ${shuffledHearts[*]}	
	echo -e "New Cards Complete\n"
	read "Press Enter to Return to Main Menu."
	clear
}

draw_cards () {
	clear
	#created length vars
	lengthSpades=${#shuffledSpades[*]}
	lengthDiamonds=${#shuffledDiamonds[*]}
	lengthClubs=${#shuffledClubs[*]}
	lengthHearts=${#shuffledHearts[*]}
	
	sumTotal=$(($lengthSpades + $lengthDiamonds + $lengthClubs + $lengthHearts))
		
	firstTime=0
	counter=0
	
	while true;
	do	
		#I added an additional if that makes sure its all in one while loop
		#This part should never repeat, breaks out the loop, or moves forward
		if [[ $firstTime == 0 ]];then		

			read -p "How many cards would you like to draw from this deck? " request

			if [[ $sumTotal -lt $request ]];then
				echo -e "There are only $sumTotal cards left in the deck but you have requested $request cards."
				read -p "Press enter to continue"
				break
			fi

			if ! [[ $request =~ [+]?[0-9] ]] 2>>/dev/null;then
				echo -e "This is NOT a valid option please try again.\n"
				read -p "Press enter to draw new cards."
				continue
			fi
			echo -e "Your cards are: \n"
			firstTime=$(($firstTime + 1))
		fi
		
		#This is checking to see if the length is 0, if so, it adds 1
		#Clunky, but it keeps it from being zero so it works for the code below
		if [[ $lengthSpades == 0 ]];then
			spades_gone=$(($spades_gone + 1))
		elif [[ $lengthDiamonds == 0 ]];then
			diamonds_gone=$(($diamonds_gone + 1))
		elif [[ $lengthClubs == 0 ]];then
			clubs_gone=$(($clubs_gone + 1))
		elif [[ $lengthHearts == 0 ]];then
			hearts_gone=$(($hearts_gone + 1))
		fi

		#Picking a random number from 0 to 3 for a random suit
		suit=$(($RANDOM%4))
			
		#Going throught the 4 suits and then removing the cards
		if [[ $suit ==  0 && $spades_gone == 0 ]];then
			cards=$(($RANDOM%$lengthSpades))
			echo -e "${shuffledSpades[$cards]}"
			shuffledSpades=(${shuffledSpades[*]:0:$cards} ${shuffledSpades[*]:$(($cards + 1))})
			counter=$(($counter + 1))
			lengthSpades=${#shuffledSpades[*]}
			sumTotal=$(($sumTotal - 1))
				
		elif [[ $suit == 1 && $diamonds_gone == 0 ]];then
			cards=$(($RANDOM%$lengthDiamonds))
			echo -e "${shuffledDiamonds[$cards]}"
			shuffledDiamonds=(${shuffledDiamonds[*]:0:$cards} ${shuffledDiamonds[*]:$(($cards + 1))})
			counter=$(($counter + 1))
			lengthDiamonds=${#shuffledDiamonds[*]}
			sumTotal=$(($sumTotal - 1))
			
		elif [[ $suit == 2 && $clubs_gone == 0 ]];then
			cards=$(($RANDOM%$lengthClubs))
			echo -e "${shuffledClubs[$cards]}"
			shuffledClubs=(${shuffledClubs[*]:0:$cards} ${shuffledClubs[*]:$(($cards + 1))})
			counter=$(($counter + 1))
			lengthClubs=${#shuffledClubs[*]}
			sumTotal=$(($sumTotal - 1))

		elif [[ $suit == 3 && $hearts_gone == 0 ]];then
			cards=$(($RANDOM%$lengthHearts))
			echo -e "${shuffledHearts[$cards]}"
			shuffledHearts=(${shuffledHearts[*]:0:$cards} ${shuffledHearts[*]:$(($cards + 1))})
			counter=$(($counter + 1))
			lengthHearts=${#shuffledHearts[*]}		
			sumTotal=$(($sumTotal - 1))
		fi
		
		#checks if the amount of cards dealt equals the requested card amt
		if [[ $request -eq $counter ]];then
			break
		fi
	done	 
	echo -e  "\n"
	read -p "Press Enter to continue"
}

#Main Function
while true;
do
	clear
	echo -e "Welcome to the card deck simulator\n
Please select form the following options:\n
\t1. Draw a selected number of cards from the current deck
\t2. Get a new deck of cards
\t3. Exit\n"

	read -p "Option#: " userInput

	echo -e "You have chosen $userInput"

	#Checking all of the inputs if its correct or restarts the main fun	
	if [[ $userInput == 1 ]];then
		#draw card function here
		draw_cards
	elif [[ $userInput == 2 ]];then
		new_cards
	elif [[ $userInput == 3 ]];then
		read -p "Press Enter to leave."
		break
	else
		echo -e "Something went wrong please try again"
	fi
done



