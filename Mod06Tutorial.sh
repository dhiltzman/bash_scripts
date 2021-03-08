#! /bin/sh

RandoInsert () {
	myArrayLength=${#myArray[*]}
	indexPosition=$(( ($RANDOM%myArrayLength) ))
	myArray=(${myArray[*]:0:$indexPosition} "$1" ${myArray[*]:$indexPosition})
}

#declare -a myArray=(44 seven 7 120 monkey cat heck 3.1 -1382 banana)
clear
read -p "Press enter to move from task to task"
clear

#Task 1 Fill the array with user input
echo -e "Task 1\n"
echo "Create an array filled with 10 items"
echo -e "Be sure to get a mis of floating point number, integers, and text\n"

inputCounter=0
while [[ $inputCounter -lt 10 ]];
do
	read -p "Please enter a number or word for index position $inputCounter: " userInput
	inputInput=$( echo $userInput | tr " " "_")
	myArray+=($userInput)
	inputCounter=$(($inputCounter+1))
done
read
clear

#Task 2 Print the length of the array
echo -e "Task 2\n"
myArrayLength=${#myArray[*]}
echo "This array has $myArrayLength items"
read
clear

#Task 3 print out the array
echo -e "Task 3\n"
echo -e "This is the array:\n"
echo ${myArray[*]}
read

#Task 4 swap first item with last item in array and print
echo -e "Task 4\n"
firstThing=${myArray[0]}
myArray[0]=${myArray[-1]}
myArray[-1]=$firstThing
echo -e "This is the array after swapping the first and last items:\n"
echo ${myArray[*]}
read

#Task 5 Print first 3 and last 3 items in array
echo -e "Task 5\n"
echo -e "These are the first three and last three items in the array:\n"
echo ${myArray[*]:0:3} ${myArray[*]: -3}
read
clear

#Task 6 Loop and print individual items in array
echo -e "Task 6\n"
echo -e "These are the elements of the array\n"
for i in ${myArray[*]};
do
	echo $i
done
read
clear

#Task 7 Check to see if cat is in array and let user know
echo -e "Task 7\n"
catFlag=0
for i in ${!myArray[*]};
do
	if [[ ${myArray[$i]} == "cat" ]]; then
		catFlag=1
		break
	fi
done

if [[ catFlag -eq 1 ]];then
	echo "There is a cat in myArray"
else
	echo "There is no cat in myArray"
fi

read
clear

#Task 8 Marvel name and pass to a function for random insertion
echo -e "Task 8\n"
read -p "Please enter the name of a Marvel character: "userHero
userHero=$( echo  $userHero | tr " " "_")
RandoInsert $userHero
echo
read
clear

#Task 9 Print out the index position of the hero, then the array
echo -e "Task 9\n"
for i in  ${!myArray[*]};
do
	if [[ ${myArray[$i]} == $userHero ]];then
		echo "$userHero is at position $i in the array"
	fi

done
echo
read
clear

#Task 10 Show the final state of the array
echo -e "Task 10\n"
echo "This array is now: ${myArray[*]}"
read
clear

#Task 11 Copy Integers to new array, sort, print
echo -e "Task 11\n"
for i in ${!myArray[*]};
do
	if [[ ${myArray[$i]} =~ ^-?[0-9]+$ ]];then
		intArray+=(${myArray[$i]})
	fi
done

intArray=($(
	for i in ${intArray[*]};
	do
		echo $i
	done | sort -n ))

echo "The integers in the original array, sort, are: ${intArray[*]}"

#Task 12 Create and unpack an array of arrays
echo -e "Task 12\n"
echo -e "These are the element of the array of arrays\n"

subarray1=(1 2 3)
subarray2=(a b c)
packing_array=('subarray1[*]' 'subarray2[*]')
my_array=('packing_array[*]')

for i in ${my_array[*]}}
do
	for j in ${!i}
	do
		for k in ${!j}
		do 
			echo $k
		done
	done
done

echo
read -p "Pres enter to end the script"

