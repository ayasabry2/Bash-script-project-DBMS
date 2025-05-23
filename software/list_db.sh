#!/usr/bin/bash
echo "------------------ list of database -----------------------"
cd ../data

ls -F |grep / |tr / " "

cd - &>/dev/null  