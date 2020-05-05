#!/bin/bash

FILE=$(find /usr/local -name "*.txt" | cut -d "." -f1)
for i in $FILE
do
mv $i.txt $i.htm
done
