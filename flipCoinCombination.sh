#!/bin/bash

function division () {
	local result=`echo "$1/$2" | awk -F "/" "{print ($1/$2)}"`
	echo $result
}

function multiplication () {
	local result=`echo "$1*$2" | awk -F "*" "{print ($1*$2)}"`
	echo $result
}

echo "Welcome To Flip Coin Combination"

HEADS=0
TAILS=1

function headsOrTails () {
	if [ $((RANDOM%2)) -eq $HEADS ]
	then
		echo "H"
	else
		echo "T"
	fi
}

numberOfRounds=0 declare -A singlet
singlet["H"]=0
singlet["T"]=0

for (( i=0; i<10; i++ ))
do
	flipCoin=$(headsOrTails)
	singlet[$flipCoin]=$((${singlet[$flipCoin]}+1))
	numberOfRounds=$(($numberOfRounds+1))
done
headsPercentage=$(division ${singlet["H"]} $numberOfRounds)
headsPercentage=$(multiplication $headsPercentage 100)
tailsPercentage=$(division ${singlet["T"]} $numberOfRounds)
tailsPercentage=$(multiplication $tailsPercentage 100)
echo "Percentage of heads is $headsPercentage"
echo "Percentage of tails is $tailsPercentage"


