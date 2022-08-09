FROM ubuntu:20.04 as builder
ENV DEBIAN_FRONTEND=noninteractive
# ENV SQUID_VER 4.16
ENV SQUID_VER 5.4
ENV SQUID_CONFIG_FILE /usr/local/squid/etc/squid.conf
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        build-essential \
        openssl \
        libssl-dev \
        pkg-config \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN mkdir /downloads && cd /downloads \
    && wget -nv http://www.squid-cache.org/Versions/v${SQUID_VER%%.*}/squid-${SQUID_VER}.tar.gz \
    && tar -zxvf squid-${SQUID_VER}.tar.gz \
    && cd /downloads/squid-${SQUID_VER} \
    && ./configure --with-default-user=proxy --with-openssl --enable-ssl-crtd \
    && make \
    && make install


FROM ubuntu:20.04
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        openssl \
        libssl-dev \
        gosu \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY --from=hairyhenderson/gomplate:v3.11.2-slim /gomplate /usr/local/bin/
COPY --from=builder /usr/local/squid /usr/local/squid
COPY cachemgr.conf errorpage.css mime.conf /etc/squid/
COPY squid.conf.gotmpl /etc/gomplate/
COPY pre.sh /pre.sh
RUN useradd -rU squid \
    && mkdir -p /etc/squid-ssl /var/lib/squid /var/cache/squid \
    && chown -R squid:squid /var/lib/squid /var/cache/squid /usr/local/squid/var/logs /usr/local/squid/var/run/ \
    && chmod 0755 /pre.sh
VOLUME ["/usr/local/squid/var/logs/"]
ENV SQUID_CONFIG_FILE=/etc/squid/squid.conf \
    PATH="${PATH}:/usr/local/squid/sbin:/usr/local/squid/libexec"
ENTRYPOINT ["/pre.sh"]
