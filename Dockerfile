ARG JELLYFIN_VERSION

FROM jellyfin/jellyfin:${JELLYFIN_VERSION}
RUN export DEBIAN_FRONTEND="noninteractive" && \
    apt-get update -y && \
    apt-get install gosu tzdata && \
    apt-get clean autoclean -y && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*
COPY --chmod=755 entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]
