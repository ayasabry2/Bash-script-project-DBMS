#!/usr/bin/bash
cd ../data
ps3="Type your table number to drop :"   
echo 
echo "----->Select your table number from the menu <--------------"
echo

array=(`ls -F | grep / | tr '/' ' '`)

select choice in "${array[@]}" 
do 
if [ "$REPLY" -gt "${#array[@]}" ]   
then 
 echo "
  $REPLY not found on the menu"
  continue 
else 
  rm -r "${array[$((REPLY-1))]}"  
  echo "
  ....your ${array[$((REPLY-1))]} DB deleted successfully ...."
  break
fi 
done 

cd - &>/dev/null   
