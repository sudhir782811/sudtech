#!/bin/bash

file=$(find /usr/local -name "*.txt" | cut -d "." -f1)
for i in $file
do
mv $i.txt $i.html
done
