#!/usr/bin/env bash

set -xeo pipefail

AUTH="YWRtaW46YWRtaW4="
OPERATOR="operator"
CCTV_VIDEO="app-video:8080"
DIR="$(dirname ${BASH_SOURCE[0]})"

function getUserId(){
  export OPERATOR_ID="$(curl -fs 'http://'$CCTV_VIDEO'/users/list' \
                             -H 'Authorization: Basic '$AUTH'' \
                        | jq -r '.data.users[]|select(.username =="'$OPERATOR'")|.id')"
}

function getServerId(){
  export SERVER_ID="$(curl -fs 'http://'$CCTV_VIDEO'/servers/list' \
                           -H 'Authorization: Basic '$AUTH'' \
                      | jq -r '.data.servers[]|select(.control.host == "'$STREAMER_ADDRESS'")|.id')"
}

function createServer(){
  ANSWER=($(curl -fs -X POST 'http://'$CCTV_VIDEO'/servers/create' \
                 -H 'Authorization: Basic '$AUTH'' \
                 -H 'Content-Type: application/json' \
                 -d "$(cat $DIR/server.json | envsubst)" \
            | jq -cr '.status, .data.id'))

  case ${ANSWER[0]} in
    200)   export SERVER_ID="${ANSWER[1]}"; return 0;;
    409) getServerId && return 0;;
    *) return 1;;
  esac
}

function createPermissions() {
  ANSWER=($(curl -fs -X POST 'http://'$CCTV_VIDEO'/permissions/create' \
              -H 'Authorization: Basic '$AUTH'' \
              -H 'Content-Type: application/json' \
              -d "$(cat $DIR/permissions.json | envsubst)" | jq -r '.status'))

  case ${ANSWER[0]} in
    200) return 0;;
    *) return 1;;
  esac
}

if [[ -n "$STREAMER_ADDRESSES" ]]; then

  getUserId
  for SERVER in $STREAMER_ADDRESSES; do
    export STREAMER_ADDRESS="$SERVER"
    createServer &&
    createPermissions || exit 1
  done
else
  exit 0
fi

