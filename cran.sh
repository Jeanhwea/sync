#!/bin/bash

ROOT="/var/services/homes/hujinghui/Archive/Mirror/"
HERE=`dirname $(realpath $0)`

CRAN_URL="rsync://mirrors.tuna.tsinghua.edu.cn/CRAN/"
CRAN_DIR=${ROOT}"CRAN"

function _sync_cran(){
	echo "==== SYNC cran START ===="
	timeout -s INT 21600 rsync -av $CRAN_URL $CRAN_DIR
	echo "==== SYNC cran DONE ===="
}

function _log_cran(){
	timeout -s INT 360 du -sh $CRAN_DIR > $HERE/log/cran.log
}

_sync_cran
_log_cran
