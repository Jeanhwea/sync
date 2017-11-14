#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/env.sh"


BOTTLES_URL="rsync://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/"
BOTTLES_DIR="$DS_MIRROR_ROOT/homebrew-bottles"

if [ ! -d $DS_MIRROR_ROOT ]; then
	echo "$DS_MIRROR_ROOT is not exsit!!!"
	exit -1
fi

function _sync_bottles(){
	echo "==== SYNC homebrew bottles START ===="
	timeout -s INT 36000 rsync -av $BOTTLES_URL $BOTTLES_DIR
	echo "==== SYNC homebrew bottles DONE ===="
}

function _log_bottles(){
	timeout -s INT 360 du -sh $BOTTLES_DIR > $HERE/log/homebrew-bottles.log
}

_sync_bottles
sleep 3
_log_bottles

