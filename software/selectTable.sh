#!/usr/bin/bash

echo "
-----> Select your Table number from the menu <--------
"
array=(`ls`)
select choice in ${array[*]}
do
	if [ $REPLY -gt ${#array[*]} ] || [ $REPLY -lt 1 ]; then
		echo "
		❌ $REPLY is not on the menu
		"
		continue
	else
		table_name=${array[$REPLY-1]}
		echo "
		✅ You selected '${table_name}' table...
		"
		break
	fi
done
echo "
📄 Contents of '$table_name':
"

if [[ -s "$table_name" ]]; then
	column_names=$(head -1 "$table_name")
	column_types=$(sed -n '2p' "$table_name")
	data_rows=$(tail -n +3 "$table_name")

	echo "🔹 Columns: $column_names"
	echo "🔹 Types  : $column_types"
	echo -e "\n📊 Data:"
	
	if [[ -z "$data_rows" ]]; then
		echo "(No records found)"
	else
		echo "$data_rows" | column -t -s ':'
	fi
else
	echo "⚠️  Table is empty."
fi
