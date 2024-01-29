#!/bin/bash

# Number of Lines
lines=5

exit=false

# Store the last arg as file if file exists
FILE=$(echo "$@" | perl -pe 's/.* (.*)$/$1/g')
ARGS=$(echo "$@" | perl -pe 's/(.*) .*$/$1/g')
[ "$ARGS" = "$FILE" ] && ARGS=""

echo $FILE
echo $ARGS

if ! [ -f $FILE ] 
then
	echo "Error: file doesn't exist"
	exit 1
fi

# Number of lines in the file with the grepped string
lines=$(grep -n $ARGS $FILE | perl -pe 's/\:.*\n/ /' | sed 's/ $//')

file_length=$(cat $FILE | wc -l)


# Adds support for multiple hits
for line in $lines
do
	upper_limit=$(( $line + $lines ))
	lower_limit=$(( $line - $lines ))

	[[ $(( $line < $lines )) == "1" ]] && LLim=0 
	[[ $(( $line + $lines > $file_length )) == "1" ]] && ULim=$FLen

	
	awk "NR>=$LLim&&NR<=$(($i-1))" $FILE
	grep --color=auto $1 $FILE
	awk "NR>=$(($i+1))&&NR<=$ULim" $FILE
	
	if ! [[ $(echo $lines | perl -pe 's/ /\n/g' | wc -l) == 1 ]]
	then	
		echo "\n---------\n"
	fi
done
