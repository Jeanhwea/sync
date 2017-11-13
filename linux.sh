#!/bin/bash
HERE=`dirname $(realpath $0)`


LINUX_URL="https://github.com/torvalds/linux.git"
LINUX_DIR="$DS_MIRROR_ROOT/repository/linux.git"

if [[ ! -d $DS_MIRROR_ROOT ]]; then
	echo "$DS_MIRROR_ROOT is not exsit!!!"
	exit -1
fi

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

function _log_linux(){
	timeout -s INT 360 du -sh $LINUX_DIR > $HERE/log/linux.log
}

if [[ ! -f "$LINUX_DIR/HEAD" ]]; then
	echo "Initializing linux.git mirror"
	_repo_init
fi

_update_linux
sleep 3
_log_linu

