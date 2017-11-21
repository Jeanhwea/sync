#!/bin/bash

export DS_MIRROR_ROOT="/Volumes/Opossum/mirror"

function _current_time() {
    date +'%Y-%m-%d %H:%M:%S'
}

function _dir_size() {
    FOLDER=$1
    du -s $FOLDER | awk '{ print $1 }'
}

function _timeout() {
    if [ -x /usr/local/bin/__timeout ]; then
        gtimeout $*
    elif [ -x /bin/_timeout ]; then
        timeout $*
    else
        echo 'error: command _timeout is not found!!!'
    fi
}


function _git_remote_url() {
    FOLDER=$1
    cd $FOLDER && git remote -v | grep origin | grep fetch | awk '{ print $2 }'
}

if [[ ! -d $DS_MIRROR_ROOT ]]; then
    echo "$DS_MIRROR_ROOT is not exsit!!!"
    exit -1
fi

