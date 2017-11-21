#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/helper.sh"


BOTTLES_URL="rsync://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/"
BOTTLES_DIR="$MIRROR/homebrew-bottles"
BOTTLES_LOG="$HERE/log/homebrew-bottles.log"

function _sync_bottles() {
    echo "==== SYNC homebrew bottles START ===="
    _timeout -s INT 36000 rsync -av $BOTTLES_URL $BOTTLES_DIR
    echo "==== SYNC homebrew bottles DONE ===="
}


# main
STARTTIME=`_current_time`

_sync_bottles
sleep 3
SIZE=`_dir_size $BOTTLES_DIR`

FINISHTIME=`_current_time`

cat >> $BOTTLES_LOG << EOF
$STARTTIME,$FINISHTIME,$SIZE,$BOTTLES_URL,$BOTTLES_DIR
EOF
