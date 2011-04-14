#!/bin/bash
sh /opt/avatainstaller/updaterepo.sh
if [  $? -eq 0 ];
then  
  echo "UP"
else
  echo "DOWN"
fi
