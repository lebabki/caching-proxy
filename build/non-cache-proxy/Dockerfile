FROM alpine:3.16
COPY pre.sh /pre.sh
COPY tinyproxy.conf.gotmpl /etc/gomplate/
RUN apk --no-cache add tinyproxy gomplate bash \
    && chmod 0755 /pre.sh
ENTRYPOINT ["/pre.sh"]
