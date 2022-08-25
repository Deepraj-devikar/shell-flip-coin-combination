#!/bin/bash

echo "Welcome To Flip Coin Combination"

function headsOrTails () {
	echo $((RANDOM%2))
}

HEADS=0
TAILS=1

flipCoin=$(headsOrTails)
if [ $flipCoin -eq $HEADS ]
then
	echo "Flip the coin and its heads"
elif [ $flipCoin -eq $TAILS ]
then
	echo "Flip the coin and its tails"
fi
