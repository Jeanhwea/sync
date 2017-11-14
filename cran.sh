#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/helper.sh"


# CRAN_URL="rsync://mirrors.tuna.tsinghua.edu.cn/CRAN/"
CRAN_URL="rsync://cran.r-project.org/CRAN/"
CRAN_DIR="$DS_MIRROR_ROOT/CRAN"
CRAN_LOG="$HERE/log/cran.log"

function _sync_cran(){
	echo "==== SYNC cran START ===="
	timeout -s INT 21600 rsync -av $CRAN_URL $CRAN_DIR
	echo "==== SYNC cran DONE ===="
}


# main
STARTTIME=`_current_time`

_sync_cran
sleep 3
SIZE=`_dir_size $CRAN_DIR`

FINISHTIME=`_current_time`


cat > $CRAN_LOG << EOF
from:   $CRAN_URL
to:     $CRAN_DIR
size:   $SIZE
start:  $STARTTIME
finish: $FINISHTIME
EOF
