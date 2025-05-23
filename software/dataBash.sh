#!/usr/bin/bash

select choice in CREATE_DB LIST_DB CONNECT_DB DROP_DB
do
case $choice in 
CREATE_DB )
        echo "creating database....."
        source ./create_db.sh
        ;;
LIST_DB )
        echo "list database....."
        source ./list_db.sh
        ;;
CONNECT_DB )
        echo "connecting database....."
        source ./connect_db.sh
        ;;
DROP_DB )
        echo "drop database....."
        source ./drop_db.sh
        ;;
*)
        echo "Invalid choice. Please select a valid option."
        ;;
esac
done
