#!/usr/bin/bash

PS3="  Type your Table number to Drop : "

echo "
-----> Select your Table number from the menu <--------
"
array=(`ls`)
select choice in "${array[@]}"
do
  if [ "$REPLY" -gt "${#array[@]}" ] || [ "$REPLY" -le 0 ]; then
    echo "$REPLY is not on the menu"
    continue
  else
    table_name="${array[$((REPLY-1))]}"
    if [ -f "$table_name" ]; then
      rm "$table_name"
      echo "
      ✅ Table '$table_name' dropped successfully...
      "
    else
      echo "❌ Table '$table_name' does not exist."
    fi
    break
  fi
done
