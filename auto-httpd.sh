#!/bin/bash

HTTPD=$(netstat -tunlp | grep httpd | wc -l)
if [ $HTTPD -eq 1 ];
then
echo "apache is runing"
else
systemctl restart httpd.service
fi
