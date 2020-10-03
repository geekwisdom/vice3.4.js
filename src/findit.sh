#!/bin/bash
filelist=`find | grep "\.c"`
for  i in $filelist 
 do
 grep "${1}" $i
 if [ $? -eq 0 ] ; then 
  echo $i
 fi
done
