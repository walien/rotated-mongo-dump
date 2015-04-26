#!/bin/bash

##### EDIT #####

maxDumpsCount=5
#user=
#pwd=
db="all"

################

echo "Cleaning old dumps"
(ls -t|head -n $maxDumpsCount; ls)|sort|uniq -u|grep .tar.gz|xargs rm
echo "... done"

dumpName=$(date "+%Y-%m-%d_%H:%M:%S")
opts="-o $dumpName"

if [ "$user" ]; then
   opts="$opts -u $user -p $pwd"
fi

if [ "$db" == "all" ]; 
  then opts="$opts --oplog"
  else opts="$opts --db $db"
fi

echo "$dumpName - Dumping db"
mongodump $opts 
tar -zcvf $dumpName.tar.gz $dumpName
rm -rf $dumpName

echo "DB dump $dumpName stored and compressed... Done !"
