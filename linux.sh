#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/helper.sh"


LINUX_URL="https://github.com/torvalds/linux.git"
LINUX_DIR="$DS_MIRROR_ROOT/repository/linux.git"
LINUX_LOG="$HERE/log/linux.log"

function _repo_init(){
	git clone --mirror $LINUX_URL $LINUX_DIR
}

function _update_linux(){
	cd $LINUX_DIR
	echo "==== SYNC linux.git START ===="
	timeout -s INT 144000 git remote -v update
	git repack -a -b -d
	echo "==== SYNC linux.git DONE ===="
}


# main
STARTTIME=`_current_time`

if [[ ! -f "$LINUX_DIR/HEAD" ]]; then
	echo "Initializing linux.git mirror"
	_repo_init
fi

_update_linux
sleep 3
SIZE=`_dir_size $LINUX_DIR`

FINISHTIME=`_current_time`


cat > $LINUX_LOG << EOF
---
- from:   $LINUX_URL
  to:     $LINUX_DIR
  size:   $SIZE
  start:  $STARTTIME
  finish: $FINISHTIME

EOF
