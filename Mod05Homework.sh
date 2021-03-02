#! /bin/sh

#Mod05 Homework
#Author: David Hiltzman

BASE_PRICE=100
payment=0
balance=0

variance=$(($RANDOM%7-4))

total_price=$(($BASE_PRICE-$variance))

echo -e "Welcome to the Soda Machine.You can enter values of 5, 10, or 25 in payment.\n"
read -p "What would you like to drink? " user_selection

echo -e "The current price of $user_selection is $total_price cents.\n"

while true;
do
	read -p "Please enter a coin: " coin_input
	
	if ! [[ $coin_input =~ ^[+-]?[0-9] ]];then
		echo -e "Not a coin value, try again.\n"
		continue
	
	fi

	if [[ $coin_input -eq 5 || $coin_input -eq 10 || $coin_input -eq 25 ]];then
		payment=$(($payment+$coin_input))
		balance=$(($total_price-$payment))
	else
		echo -e "That is not a valid coin. Please try again.\n"
		continue
	fi
	
	if [[ $balance -gt 0 ]];then
		echo -e "You still owe $balance cents.\n"
		continue
	elif [[ $balance -lt 0 ]];then
		echo -e "You have been refunded $balance cents\n"
		break
	else
		break
	fi
done

echo -e "Enjoy your $user_selection !\n"
read -p "Press Enter to leave the soda machine."
clear
