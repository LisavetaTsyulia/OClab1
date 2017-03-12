#!/bin/bash
NAME=$1
DIRECTORY=$2
FILE=$3
ERR_LOG="/tmp/err.log"

exec 6>&2 2>$ERR_LOG

find $(readlink -f "$DIRECTORY") -type f -user $NAME -printf "%p %s\n" |tee $FILE | wc -l

exec 2>&6 6>&-
sed "s/.[a-zA-Z ]*:/`basename $0`:/" < $ERR_LOG >&2

rm $ERR_LOG
