#!/bin/bash

ROOT="/var/services/homes/hujinghui/Archive/Mirror/"
HERE=`dirname $(realpath $0)`

GIT_URL="https://github.com/git/git.git"
GIT_DIR=${ROOT}"repository/git.git"

function _repo_init(){
	git clone --mirror $GIT_URL $GIT_DIR
}

function _update_git(){
	cd $GIT_DIR
	echo "==== SYNC git.git START ===="
	timeout -s INT 3600 git remote -v update
	git repack -a -b -d
	echo "==== SYNC git.git DONE ===="
}

function _log_git(){
	timeout -s INT 360 du -sh $GIT_DIR > $HERE/log/git.log
}

if [[ ! -f "$GIT_DIR/HEAD" ]]; then
	echo "Initializing git.git mirror"
	_repo_init
fi

_update_git
_log_git

