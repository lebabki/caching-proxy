FROM rpardini/docker-registry-proxy:0.6.4
COPY pre.sh /pre.sh
COPY nginx.conf.gotmpl /etc/gomplate/
RUN apk --no-cache add gomplate ca-certificates \
    && chmod 0755 /pre.sh
ENTRYPOINT ["/pre.sh"]
