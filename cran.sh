#!/bin/bash
HERE=`dirname $0`
source "$HERE/helper.sh"


CRAN_URL="rsync://mirrors.tuna.tsinghua.edu.cn/CRAN/"
# CRAN_URL="rsync://cran.r-project.org/CRAN/"
CRAN_DIR="$MIRROR/CRAN"
CRAN_LOG="$HERE/log/cran.log"

function _sync_cran() {
    echo "==== SYNC cran START ===="
    _timeout -s INT 21600 rsync -av $CRAN_URL $CRAN_DIR
    echo "==== SYNC cran DONE ===="
}


# main
STARTTIME=`_current_time`

_sync_cran
sleep 3
SIZE=`_dir_size $CRAN_DIR`

FINISHTIME=`_current_time`


cat >> $CRAN_LOG << EOF
$STARTTIME,$FINISHTIME,$SIZE,$CRAN_URL,$CRAN_DIR
EOF
