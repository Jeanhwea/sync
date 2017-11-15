#!/bin/bash

export DS_MIRROR_ROOT="/var/services/homes/hujinghui/Archive/Mirror"

function _current_time(){
	date +'%Y-%m-%d %H:%M:%S'
}

function _dir_size(){
	FOLDER=$1
	du -sh $FOLDER | awk '{ print $1 }'
}

function _git_remote_url(){
	FOLDER=$1
	cd $FOLDER && git remote -v | grep origin | grep fetch | awk '{ print $2 }'
}

if [[ ! -d $DS_MIRROR_ROOT ]]; then
	echo "$DS_MIRROR_ROOT is not exsit!!!"
	exit -1
fi

