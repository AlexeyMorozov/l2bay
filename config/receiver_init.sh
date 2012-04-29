#!/bin/sh
### BEGIN INIT INFO
# Provides:          receiver
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: L2bay receiver
# Description:       Receives info from l2bay sniffer clients
### END INIT INFO
set -e

APP_ROOT=/home/deployer/_build
CMD="$APP_ROOT/receiver localhost:2345"
AS_USER=deployer
set -u

case "$1" in
start)
  run "$CMD"
  ;;
*)
  echo >&2 "Usage: $0 <start>"
  exit 1
  ;;
esac
