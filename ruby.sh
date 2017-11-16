#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/helper.sh"


RUBY_URL="rsync://mirrors.ustc.edu.cn/ruby/"
RUBY_DIR="$DS_MIRROR_ROOT/ruby"
RUBY_LOG="$HERE/log/ruby.log"

function _sync_ruby(){
	echo "==== SYNC ruby START ===="
	timeout -s INT 3600 rsync -av $RUBY_URL $RUBY_DIR
	echo "==== SYNC ruby DONE ===="
}


# main
STARTTIME=`_current_time`

_sync_ruby
sleep 3
SIZE=`_dir_size $RUBY_DIR`

FINISHTIME=`_current_time`

cat >> $RUBY_LOG << EOF
---
- from:   $RUBY_URL
  to:     $RUBY_DIR
  size:   $SIZE
  start:  $STARTTIME
  finish: $FINISHTIME

EOF
