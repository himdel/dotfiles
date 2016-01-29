#!/bin/bash
NAME=`hostname`-`date '+%Y%m%d'`
scp -r ~/.purple/logs himdel.mine.nu:logs/"$NAME"
ssh himdel.mine.nu "cd logs; nohup ./join.sh '$NAME' & exit"
