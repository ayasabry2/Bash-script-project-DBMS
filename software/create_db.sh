#!/usr/bin/bash
cd ../data

while true
do 
echo "write your DB name"
read db_name

case $db_name in   

'')
echo "the name cant be empty"
    continue ;;
*[[:space:]]* )  
echo "the name cant have space "
    continue;;
[0-9]*)
echo "the name cant start with number "
    continue;;
*[a-zA-Z_]*[a-zA-Z_] | [a-zA-Z_])   
if ls -F | grep -q "^$db_name/$"   
then 
echo "db is already exist"
else 
    mkdir "$db_name"
fi
break;;
*)
echo "write a valid name"
   continue;;
esac
done

cd - &>/dev/null   
