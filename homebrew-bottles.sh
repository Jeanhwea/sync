#!/bin/bash

ROOT="/var/services/homes/hujinghui/Archive/Mirror/"
HERE=`dirname $(realpath $0)`

BOTTLES_URL="rsync://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/"
BOTTLES_DIR=${ROOT}"homebrew-bottles"

function _sync_bottles(){
	echo "==== SYNC homebrew bottles START ===="
	timeout -s INT 3600 rsync -av $BOTTLES_URL $BOTTLES_DIR
	echo "==== SYNC homebrew bottles DONE ===="
}

function _log_bottles(){
	timeout -s INT 360 du -sh $BOTTLES_DIR > $HERE/log/homebrew-bottles.log
}

_sync_bottles
sleep 3
_log_bottles

