#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/helper.sh"


RUBYGEMS_URL="rsync://mirrors.ustc.edu.cn/rubygems/"
RUBYGEMS_DIR="$DS_MIRROR_ROOT/rubygems"
RUBYGEMS_LOG="$HERE/log/rubygems.log"

function _sync_rubygems() {
	echo "==== SYNC rubygems START ===="
	timeout -s INT 36000 rsync -av $RUBYGEMS_URL $RUBYGEMS_DIR
	echo "==== SYNC rubygems DONE ===="
}


# main
STARTTIME=`_current_time`

_sync_rubygems
sleep 3
SIZE=`_dir_size $RUBYGEMS_DIR`

FINISHTIME=`_current_time`

cat >> $RUBYGEMS_LOG << EOF
$STARTTIME,$FINISHTIME,$SIZE,$RUBYGEMS_URL,$RUBYGEMS_DIR
EOF
