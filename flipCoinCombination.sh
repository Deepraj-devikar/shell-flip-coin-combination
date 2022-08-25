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

function sForCombination () {
	if [ $1 -eq $HEADS ]
	then
		echo "H"
	else
		echo "T"
	fi
}

# Singlet Combination
echo ""
echo "Percentage For Singlet"
numberOfRounds=0
declare -A singlet
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

# Doublet Combination
echo ""
echo "Percentage For Doublet"
numberOfRounds=0
declare -A doublet
doublet["HH"]=0
doublet["HT"]=0
doublet["TH"]=0
doublet["TT"]=0
for (( i=0; i<20; i++ ))
do
	flipCoin="$(headsOrTails)$(headsOrTails)"
	doublet[$flipCoin]=$((${doublet[$flipCoin]}+1))
	numberOfRounds=$(($numberOfRounds+1))
done
echo "Percentage of HH is $(multiplication $(division ${doublet['HH']} $numberOfRounds) 100)"
echo "Percentage of HT is $(multiplication $(division ${doublet['HT']} $numberOfRounds) 100)"
echo "Percentage of TH is $(multiplication $(division ${doublet['TH']} $numberOfRounds) 100)"
echo "Percentage of TT is $(multiplication $(division ${doublet['TT']} $numberOfRounds) 100)"

# Triplet Combination
echo ""
echo "Percentage For Triplet"
numberOfRounds=0
declare -A triplet
for (( i=0; i<2; i++ ))
do
	is=$(sForCombination $i)
	for (( j=0; j<2; j++ ))
	do
		js=$(sForCombination $j)
		for (( k=0; k<2; k++ ))
		do
			ks=$(sForCombination $k)
			s="$is$js$ks"
			triplet[$s]=0
		done
	done
done
for (( i=0; i<40; i++ ))
do
	flipCoin="$(headsOrTails)$(headsOrTails)$(headsOrTails)"
	triplet[$flipCoin]=$((${triplet[$flipCoin]}+1))
	numberOfRounds=$(($numberOfRounds+1))
done
for combination in ${!triplet[@]}
do
	echo "percentage of $combination is $(multiplication $(division ${triplet[$combination]} $numberOfRounds) 100)"
done
