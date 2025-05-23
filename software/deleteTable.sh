#!/usr/bin/bash

 
echo "Select your Table number from the menu"

array=(`ls`)

select choice in "${array[@]}"
do
  if [ "$REPLY" -gt "${#array[@]}" ] || [ "$REPLY" -le 0 ]; then
    echo "$REPLY is not on the menu"
    continue
  else
    echo "You selected ${array[$((REPLY-1))]} Table..."
    table_name="${array[$((REPLY-1))]}"
    break
  fi
done
 
select choice in DELETE_ALL DELETE_ROW
do
  case $choice in
    DELETE_ALL)
       
      if [ -f "$table_name" ]; then
        > "$table_name"   
        echo "✅ Table '$table_name' deleted successfully."
      else
        echo "❌ The table '$table_name' does not exist."
      fi
      break
      ;;
      
    DELETE_ROW)
      if [ ! -f "$table_name" ]; then
        echo "❌ The table '$table_name' does not exist."
        break
      fi

      while true
      do
        read -p "Input the 'id' of the row to delete: " id_value
        if [ -z "$id_value" ]; then
          echo "❌ The 'id' cannot be empty. Please enter a valid 'id'."
          continue
        fi

        row=$(awk -F':' -v id="$id_value" '$1 == id {print $0}' "$table_name")
        if [ -n "$row" ]; then
          
          sed -i "/^$id_value:/d" "$table_name"
          echo "✅ Row with 'id' '$id_value' deleted successfully."
          break
        else
          echo "❌ The 'id' '$id_value' does not exist in the table."
          continue
        fi
      done
      break
      ;;
      
    *)
      echo "❌ Invalid choice. Please select a valid option."
      ;;
  esac
done
