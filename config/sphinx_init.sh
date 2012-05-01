#!/bin/sh
### BEGIN INIT INFO
# Provides:          sphinxsearch
# Required-Start:    $local_fs $remote_fs $syslog $network $time
# Required-Stop:     $local_fs $remote_fs $syslog $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Fast standalone full-text SQL search engine
# Description:       Start, stop, restart sphinx daemon for a specific application.
### END INIT INFO
set -e

# Feel free to change any of the following variables for your app:
TIMEOUT=${TIMEOUT-60}
APP_ROOT=/home/deployer/apps/l2bay/current
CMD="cd $APP_ROOT/config; ./sphinx_cmd.sh"
AS_USER=deployer
set -u

run () {
  if [ "$(id -un)" = "$AS_USER" ]; then
    eval $1
  else
    su -c "$1" - $AS_USER
  fi
}

run "$CMD $1"
