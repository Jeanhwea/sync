#!/bin/bash
HERE=`cd $(dirname $0);pwd`
source "$HERE/helper.sh"


# LINUX_URL="https://github.com/torvalds/linux.git"
# LINUX_URL="git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
LINUX_URL="https://mirrors.tuna.tsinghua.edu.cn/git/linux.git"
LINUX_DIR="$MIRROR/repository/linux.git"
LINUX_LOG="$HERE/log/linux.log"

function _repo_init() {
    git clone --mirror $LINUX_URL $LINUX_DIR
}

function _update_linux() {
    cd $LINUX_DIR
    echo "==== SYNC linux.git START ===="
    _timeout -s INT 144000 git remote -v update
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


cat >> $LINUX_LOG << EOF
$STARTTIME,$FINISHTIME,$SIZE,$LINUX_URL,$LINUX_DIR
EOF
