#!/bin/bash
HERE=`dirname $(realpath $0)`
source "$HERE/helper.sh"


GIT_URL="https://github.com/git/git.git"
GIT_DIR="$MIRROR/repository/git.git"
GIT_LOG="$HERE/log/git.log"

function _repo_init() {
    git clone --mirror $GIT_URL $GIT_DIR
}

function _update_git() {
    cd $GIT_DIR
    echo "==== SYNC git.git START ===="
    _timeout -s INT 36000 git remote -v update
    git repack -a -b -d
    echo "==== SYNC git.git DONE ===="
}


# main
STARTTIME=`_current_time`

if [[ ! -f "$GIT_DIR/HEAD" ]]; then
    echo "Initializing git.git mirror"
    _repo_init
fi

_update_git
sleep 3
SIZE=`_dir_size $GIT_DIR`

FINISHTIME=`_current_time`


cat >> $GIT_LOG << EOF
$STARTTIME,$FINISHTIME,$SIZE,$GIT_URL,$GIT_DIR
EOF
