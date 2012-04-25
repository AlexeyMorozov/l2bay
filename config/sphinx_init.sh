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

TIMEOUT=${TIMEOUT-60}
APP_ROOT=/home/deployer/apps/l2bay/current
PID=$APP_ROOT/tmp/pids/searchd.production.pid
CMD="searchd --config $APP_ROOT/config/sphinx.conf"
AS_USER=deployer
set -u

OLD_PIN="$PID.oldbin"

sig () {
  test -s "$PID" && kill -$1 `cat $PID`
}

oldsig () {
  test -s $OLD_PIN && kill -$1 `cat $OLD_PIN`
}

run () {
  if [ "$(id -un)" = "$AS_USER" ]; then
    eval $1
  else
    su -c "$1" - $AS_USER
  fi
}

case "$1" in
start)
  sig 0 && echo >&2 "Already running" && exit 0
  run "$CMD"
  ;;
stop)
  sig QUIT && exit 0
  echo >&2 "Not running"
  ;;
force-stop)
  sig TERM && exit 0
  echo >&2 "Not running"
  ;;
restart|reload)
  sig HUP && echo reloaded OK && exit 0
  echo >&2 "Couldn't reload, starting '$CMD' instead"
  run "$CMD"
  ;;
reindex)
  sig 0 && run "indexer --all --rotate" && exit 0
	run "indexer --all"
	echo "Reindexed"
	echo
	exit $?
	;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|force-stop|reindex>"
  exit 1
  ;;
esac
