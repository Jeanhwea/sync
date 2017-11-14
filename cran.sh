#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/env.sh"


# CRAN_URL="rsync://mirrors.tuna.tsinghua.edu.cn/CRAN/"
CRAN_URL="rsync://cran.r-project.org/CRAN/"
CRAN_DIR="$DS_MIRROR_ROOT/CRAN"

if [[ ! -d $DS_MIRROR_ROOT ]]; then
	echo "$DS_MIRROR_ROOT is not exsit!!!"
	exit -1
fi

function _sync_cran(){
	echo "==== SYNC cran START ===="
	timeout -s INT 21600 rsync -av $CRAN_URL $CRAN_DIR
	echo "==== SYNC cran DONE ===="
}

function _log_cran(){
	timeout -s INT 360 du -sh $CRAN_DIR > $HERE/log/cran.log
}

_sync_cran
sleep 3
_log_cran
