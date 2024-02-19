#!/bin/sh
set -e

if [ "$(id -u)" -eq 0 ]; then
echo "port 6379
requirepass $KEYDB_PASSWORD
masterauth $KEYDB_PASSWORD
multi-master yes
active-replica yes
save \"\"
repl-diskless-sync yes" >/etc/keydb/keydb.conf

  bash -c '
    set -e;
    HOST_BASENAME="${HOSTNAME%_*}";
    for ((i=1; i<=$REPLICAS; i++)); do
      if [[ "$HOSTNAME" != "$HOST_BASENAME"_$i ]]; then
        echo "replicaof "$HOST_BASENAME"_$i 6379" >> /etc/keydb/keydb.conf;
      fi
    done
  '
fi

exec /usr/local/bin/docker-entrypoint.sh "$@"