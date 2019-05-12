#!/bin/bash

logdir=/var/log
root_id=0
lines=25

if [ $UID -ne $root_id ];
then
echo "this not root user to run this command"
fi

cd $logdir
tail -25 messages > tmplog
mv tmplog messages
echo "log is cleaned" 
