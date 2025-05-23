#!/usr/bin/bash
echo "
-----> Select your Table number from the menu <--------
"
array=($(ls))

select choice in "${array[@]}"
do
	if [[ "$REPLY" -gt "${#array[@]}" || "$REPLY" -le 0 ]]; then
		echo "
		$REPLY is not on the menu. Please select a valid number.
		"
		continue
	else
		table_name="${array[$((REPLY-1))]}"
		echo "
		✅ You selected '$table_name' Table...
		"
		break
	fi
done	


num_fields=$(head -1 "$table_name" | awk -F: '{print NF}')

row=""

for ((i=1; i<=num_fields; i++))
do
	read -p "Insert field #$i: " field
	while [[ -z "$field" ]]; do
		echo "❌ Field cannot be empty. Please enter a value."
		read -p "Insert field #$i: " field
	done
	if [[ $i -lt num_fields ]]; then
		row+="$field:"
	else
		row+="$field"
	fi
done
echo "$row" >> "$table_name"
echo "✅ Data inserted successfully into '$table_name'"
