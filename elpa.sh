#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/helper.sh"


ELPA_URL="rsync://mirrors.tuna.tsinghua.edu.cn/elpa/"
ELPA_DIR="$MIRROR/elpa"
ELPA_LOG="$HERE/log/elpa.log"

function _sync_elpa() {
    echo "==== SYNC elpa START ===="
    _timeout -s INT 7200 rsync -av $ELPA_URL $ELPA_DIR
    echo "==== SYNC elpa DONE ===="
}


# main
STARTTIME=`_current_time`

_sync_elpa
sleep 3
SIZE=`_dir_size $ELPA_DIR`

FINISHTIME=`_current_time`

cat >> $ELPA_LOG << EOF
$STARTTIME,$FINISHTIME,$SIZE,$ELPA_URL,$ELPA_DIR
EOF
