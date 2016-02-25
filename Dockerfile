FROM ubuntu:16.04

#ENV LC_ALL en_US.UTF-8
#LANG=en_US.UTF-8
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR="/var/lib/plexmediaserver/Library/Application Support" \
    PLEX_MEDIA_SERVER_HOME=/usr/lib/plexmediaserver \
    PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS=6 \
    PLEX_MEDIA_SERVER_TMPDIR=/tmp \
    LD_LIBRARY_PATH=/usr/lib/plexmediaserver

RUN apt-get update &&\
  apt-get upgrade -y &&\
  apt-get install -yq curl &&\
  curl -o plexmediaserver_amd64.deb -L $(curl -qLS https://plex.tv/downloads |\
    grep Ubuntu64 |\
    sed 's|.*\(https://downloads.plex.tv/plex-media-server/.*/plexmediaserver_.*_amd64.deb\).*|\1|') &&\
  dpkg -i plexmediaserver_amd64.deb &&\
  rm plexmediaserver_amd64.deb &&\
  mkdir -p "${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}" &&\
  mkdir -p /media &&\
  ln -s /var/lib/plexmediaserver/Library/Application\ Support/Plex\ Media\ Server/Logs /logs

# default server port
EXPOSE 32400

# logs and media mounts
VOLUME ["/logs", "/media"]

WORKDIR /usr/lib/plexmediaserver
ENTRYPOINT ["./start.sh"]
