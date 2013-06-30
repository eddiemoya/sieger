#!/bin/sh

function json_value  {
  	local __json_string=$1;
	local __json_key=$2
	value=$( echo "$__json_string" | jsawk -q "$__json_key"| cut -d "|" -f 2 | cut -d '"' -f 2);
	echo "$value"
}

function json_parse  {
	local __json_string=$1;
	local __json_key=$2
	value=$( echo "$__json_string" | jsawk -q "$__json_key");
	echo "$value"
}

configpath="$HOME/sieger/sieger.conf";
echo $configpath;
config="$(cat $configpath)"

settings=`json_parse "$config" '[0]..settings[0]'`;
siegetime=`json_value "$config" '[0]..time'`;
sleeptime=`json_value "$config" '[0]..sleep'`;
concurrance=`json_value "$settings" '[0]..concurrance'`;

paths=`json_parse "$config" '[0]..paths[0]'`;
count="$(echo $paths | jsawk -a 'return this.length')";

space="** ******************************************************* **";

echo "\n\n"
echo "$space";
echo "** \t\t** PATH GROUP COUNT: $count **";
echo "$space";

count=$(expr $count - 1);
for (( $count; count>=0 ; count--)); do

	filepath=`json_value "$paths" "[$count]..path"`;
	message=`json_value "$paths" "[$count]..message"`;
	repeat=`json_value "$paths" "[$count]..repeats"`;
	remaining=$(expr $count + 1);
	filepath=$(eval echo $filepath);

	echo "\n";
	echo "$space";
	echo "$space";
	echo "** \t\t** PATH GROUPS REMAINING: $remaining **";
	echo "$space";
	echo "$space";
	echo "**"
	echo "** MESSAGE........$message";
	echo "** PATH...........$filepath";
 	echo "** TIME...........$siegetime";
    	echo "** CONCURRANCE....$concurrance";
    	echo "** REPEATS........$repeat";
    	echo "**"
    	echo "$space";
    	echo "$space";
	
	for (( $repeat; repeat>=0 ; repeat--)); do
		if [[ $1 == "-test" ]] ; then
			echo "$filepath, $message $siegetime, $concurrance";
		else
			siege -c "$concurrance" -t "$siegetime" -f "$filepath" -m "$message"
		fi
		sleep $sleeptime;
	done
	
done
