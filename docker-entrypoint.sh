#!/bin/sh
set -eu

PORT="${PORT:-9998}"
JAVA_OPTS="${JAVA_OPTS:-}"

export PORT
export JAVA_OPTS

exec sh -c 'exec java $JAVA_OPTS -jar /app/tika-server.jar -h 0.0.0.0 -p "$PORT"'
