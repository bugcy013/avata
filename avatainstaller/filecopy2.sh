#!/bin/bash


rsync -a / /TARGET --exclude=/{TARGET,live,cdrom,mnt,proc,sys,media}
