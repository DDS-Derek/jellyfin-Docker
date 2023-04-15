#!/bin/bash
# shellcheck shell=bash

PUID=${PUID:-1000}
PGID=${PGID:-1000}
UMASK=${UMASK:-022}

umask ${UMASK}
chown ${PUID}:${PGID} \
    /cache \
    /config

exec gosu ${PUID}:${PGID} \
    ./jellyfin/jellyfin \
    --datadir "/config" \
    --cachedir "/cache" \
    --ffmpeg "/usr/lib/jellyfin-ffmpeg/ffmpeg" \
    $*