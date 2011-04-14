#!/bin/bash
host 8.8.4.4 > /dev/null
if [  $? -eq 0 ];
then  
  echo "UP"
else
  echo "DOWN"
fi
