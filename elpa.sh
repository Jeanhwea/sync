#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/env.sh"


ELPA_URL="rsync://mirrors.tuna.tsinghua.edu.cn/elpa/"
ELPA_DIR="$DS_MIRROR_ROOT/elpa"

if [[ ! -d $DS_MIRROR_ROOT ]]; then
	echo "$DS_MIRROR_ROOT is not exsit!!!"
	exit -1
fi

function _sync_elpa(){
	echo "==== SYNC elpa START ===="
	timeout -s INT 3600 rsync -av $ELPA_URL $ELPA_DIR
	echo "==== SYNC elpa DONE ===="
}

function _log_elpa(){
	timeout -s INT 360 du -sh $ELPA_DIR > $HERE/log/elpa.log
}

_sync_elpa
sleep 3
_log_elpa

