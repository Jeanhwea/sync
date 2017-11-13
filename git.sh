#!/bin/bash
HERE=`dirname $(realpath $0)`


GIT_URL="https://github.com/git/git.git"
GIT_DIR="$DS_MIRROR_ROOT/repository/git.git"

if [ ! -d $DS_MIRROR_ROOT ]; then
	echo "$DS_MIRROR_ROOT is not exsit!!!"
	exit -1
fi

function _repo_init(){
	git clone --mirror $GIT_URL $GIT_DIR
}

function _update_git(){
	cd $GIT_DIR
	echo "==== SYNC git.git START ===="
	timeout -s INT 36000 git remote -v update
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
sleep 3
_log_git

