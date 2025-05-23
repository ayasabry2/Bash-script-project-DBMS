#!/usr/bin/bash
cd ../data
ps3="Type your DB number to drop :"
echo 
echo "-----> Select your DB number from the menu <--------------"
echo

array=(`ls -F | grep / | tr '/' ' '`)

select choice in "${array[@]}" 
do 
if [ "$REPLY" -gt "${#array[@]}" ]   
then 
  echo "
  $REPLY not found in the menu. Please select a valid number."
  continue 
else 
cd "${array[$((REPLY-1))]}"  
  echo "
   
   you are connected to ${array[$((REPLY-1))]} DB...."
   echo
  break
fi 
done 

echo 
ps3="Type your choice number :"

select choice in CREATE_TABLE LIST_TABLE DROP_TABLE INSERT_IN_TABLE SELECT_FROM_TABLE DELETE_FROM_TABLE UPDATE_FROM_TABLE
do 
 case $choice in
  CREATE_TABLE)
    echo "🛠️ Creating a new table..."
    source ../../software/createTable.sh
    ;;
  LIST_TABLE)
    echo "📋 Listing all tables..."
    source ../../software/listTable.sh
    ;;
  DROP_TABLE)
    echo "🗑️ Dropping a table..."
    source ../../software/dropTable.sh
    ;;
  INSERT_IN_TABLE)
    echo "📥 Inserting data into the table..."
    source ../../software/insertTable.sh
    ;;
  SELECT_FROM_TABLE)
    echo "🔍 Selecting data from the table..."
    source ../../software/selectTable.sh
    ;;
  DELETE_FROM_TABLE)
    echo "❌ Deleting data from the table..."
    source ../../software/deleteTable.sh
    ;;
  UPDATE_FROM_TABLE)
    echo "✏️ Updating table data..."
    source ../../software/updateTable.sh
    ;;
  *)
    echo "❗ Invalid choice. Please select a valid option."
    ;;
 esac
done

cd - &>/dev/null  
