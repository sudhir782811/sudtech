#!/bin/bash

FILE=$(ls /usr/local | grep .html)
for i in $FILE
do
rm $i
done
