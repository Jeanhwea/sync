#!/bin/bash

ROOT="/var/services/homes/hujinghui/Archive/Mirror/"
HERE=`dirname $(realpath $0)`

ELPA_URL="rsync://mirrors.tuna.tsinghua.edu.cn/elpa/"
ELPA_DIR=${ROOT}"elpa"

function _sync_elpa(){
	echo "==== SYNC elpa START ===="
	timeout -s INT 3600 rsync -av $ELPA_URL $ELPA_DIR
	echo "==== SYNC elpa DONE ===="
}

function _log_elpa(){
	timeout -s INT 360 du -sh $ELPA_DIR > $HERE/log/elpa.log
}

_sync_elpa
_log_elpa

