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
ENV SQUID_CONFIG_FILE /usr/local/squid/etc/squid.conf
RUN apt-get update \
    && apt-get install --no-install-recommends -y \
        ca-certificates \
        openssl \
        libssl-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
COPY --from=builder /usr/local/squid /usr/local/squid
RUN touch /usr/local/squid/var/logs/access.log \
    && touch /usr/local/squid/var/logs/cache.log \
    && useradd -rU squid
VOLUME ["/usr/local/squid/var/logs/"]
