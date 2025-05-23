#!/usr/bin/bash

echo "
     ---------- The tables in database -------------------"
ls -s

while true 
do 
  read -p "Enter the name of the table to create: " table_name

  case $table_name in 
    '') 
      echo "❌ The name can't be empty."
      continue
      ;;
    *[[:space:]]*) 
      echo "❌ The name should not contain spaces."
      continue
      ;;
    [0-9]*) 
      echo "❌ The name can't start with digits."
      continue
      ;;
    *)
      if [[ -e "$table_name" ]]; then   
          echo "❌ Table already exists."
          continue
      else
          touch "$table_name"
          echo "✅ Table '$table_name' created successfully."
      fi 
      break
      ;;
  esac
done

 
while true 
do 
  read -p "Enter the number of columns in table '$table_name': " col_num
  if [[ "$col_num" =~ ^[1-9][0-9]*$ ]]; then
    echo "✅ The number of columns is $col_num."
    break
  else
    echo "❌ Write a valid positive number."
  fi
done
 
columns="id:"
types="integer:"

for ((i=1; i<=col_num; i++))  
do 
  while true
  do
    read -p "Enter name for column #$i: " col_name

    case $col_name in 
      '') 
        echo "❌ The name can't be empty."
        continue ;;
      *[[:space:]]*) 
        echo "❌ The name should not contain spaces."
        continue ;;
      [0-9]*) 
        echo "❌ The name can't start with digits."
        continue ;;
      *[^a-zA-Z0-9_]*)
        echo "❌ The name should not contain special characters."
        continue ;;
    esac

    if [[ "$col_name" == "id" ]]; then
      echo "❌ 'id' is a reserved column name."
      continue
    fi
 
    if grep -qw "$col_name" <<< "$columns"; then
      echo "❌ The column name '$col_name' already exists."
      continue
    fi
 
    columns+="$col_name:"
    break
  done
 
  while true
  do
    echo "=> Select a type for column '$col_name':"
    select dtype in "string" "integer" "boolean" "date"; do
      case $dtype in
        string|integer|boolean|date)
          types+="$dtype:"
          break
          ;;
        *) 
          echo "❌ Invalid choice. Please select a valid option."
          ;;
      esac
    done
    break
  done
done
 
columns="${columns%:}"
types="${types%:}"
echo "$columns" >> "$table_name"
echo "$types" >> "$table_name"
echo -e "\n✅ Table structure for '$table_name' created:"
echo "Columns : $columns"
echo "Types   : $types"