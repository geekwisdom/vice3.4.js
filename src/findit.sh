#!/bin/bash
filelist=`find | grep "\.c"`
for  i in $filelist 
 do
 grep "maincpu_mainloop();" $i
 if [ $? -eq 0 ] ; then 
  echo $i
 fi
done
