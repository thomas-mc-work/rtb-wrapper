FROM debian:9

RUN apt-get update -q

# setup bats
ENV BATS_VERSION 0.4.0
ENV DEBIAN_FRONTEND noninteractive

RUN \
    apt-get install -yq --no-install-recommends curl ca-certificates bash rsync dash \
    && curl -Lo "/tmp/bats.tar.gz" \
        "https://github.com/sstephenson/bats/archive/v${BATS_VERSION}.tar.gz" \
    && tar -xf "/tmp/bats.tar.gz" -C /tmp/ \
    && bash "/tmp/bats-${BATS_VERSION}/install.sh" /usr/local \
    && rm -rf /tmp/*

# prepare rsync-tmbackup
# release 74f418d561b43243aa31e17426087befc066c870 on 2017-09-26
RUN \
  curl -Lo /usr/local/bin/rsync_tmbackup.sh \
    https://github.com/laurent22/rsync-time-backup/raw/74f418d561b43243aa31e17426087befc066c870/rsync_tmbackup.sh \
  && chmod +x /usr/local/bin/rsync_tmbackup.sh

# prepare testcase
RUN \
  mkdir /target /source \
  && touch "/target/backup.marker"
COPY test/example-source /source

# prepare application
COPY rtb-wrapper.sh /opt/
RUN chmod +x /opt/rtb-wrapper.sh

# prepare configuration
COPY "test/conf.d/*" "/root/.rsync_tmbackup/conf.d/"
COPY "test/*.lst" /

CMD ["/usr/local/bin/bats", "/tests"]
