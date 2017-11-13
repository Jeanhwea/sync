#!/bin/bash

ROOT="/var/services/homes/hujinghui/Archive/Mirror/"
HERE=`dirname $(realpath $0)`

LINUX_URL="https://mirrors.tuna.tsinghua.edu.cn/git/linux.git"
LINUX_DIR=${ROOT}"repository/linux.git"

function _repo_init(){
	git clone --mirror $LINUX_URL $LINUX_DIR
}

function _update_linux(){
	cd $LINUX_DIR
	echo "==== SYNC linux.git START ===="
	timeout -s INT 3600 git remote -v update
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

