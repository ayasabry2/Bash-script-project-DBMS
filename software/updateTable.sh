#!/usr/bin/bash
echo "
-----> Select your Table number from the menu <--------
"
array=($(ls))

select choice in "${array[@]}"
do
	if [[ $REPLY -gt ${#array[@]} || $REPLY -le 0 ]]; then
		echo "
		❌ $REPLY is not on the menu.
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
read -p "Enter the id (PK) of the row to update: " pk
 
row=$(awk -F: -v id="$pk" '$1 == id {print $0}' "$table_name")
if [[ -n "$row" ]]; then

	columns=($(head -1 "$table_name" | awk 'BEGIN{RS=":"} {print $1}'))
	num_fields=${#columns[@]}

	new_row="$pk"
	
	for ((i=1; i<num_fields; i++)); do
		read -p "Enter value for (${columns[$i]}): " field
		while [[ -z "$field" ]]; do
			echo "❌ Field cannot be empty."
			read -p "Enter value for (${columns[$i]}): " field
		done

		new_row+=":$field"
	done

 
	escaped_old_row=$(printf '%s\n' "$row" | sed -e 's/[]\/$*.^[]/\\&/g')
	sed -i "s|^$escaped_old_row\$|$new_row|" "$table_name"

	echo "✅ Row updated successfully."

else
	echo "❌ ID (PK) '$pk' doesn't exist. Please enter a valid ID."
	 
fi
