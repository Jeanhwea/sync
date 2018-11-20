#!/bin/bash
HERE=`cd $(dirname $0);pwd`
PARENT=`dirname $HERE`

export MIRROR=${MIRROR:-"$PARENT"}

function _current_time() {
  date +'%Y-%m-%d %H:%M:%S'
}

function _dir_size() {
  FOLDER=$1
  du -k -s $FOLDER | awk '{ print $1 }'
}

function _timeout() {
  if [ -x /usr/local/bin/gtimeout ]; then
    /usr/local/bin/gtimeout $*
  elif [ -x /usr/bin/timeout ]; then
    /usr/bin/timeout $*
  elif [ -x /bin/timeout ]; then
    /bin/timeout $*
  else
    echo 'error: command timeout is not found!!!'
  fi
}

function _git_remote_url() {
  FOLDER=$1
  cd $FOLDER && git remote -v | grep origin | grep fetch | awk '{ print $2 }'
}

if [[ ! -d $MIRROR ]]; then
  echo "$MIRROR is not exsit!!!"
  exit -1
fi
