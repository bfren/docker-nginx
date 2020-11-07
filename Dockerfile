FROM bcgdesign/alpine-s6:latest

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx + Certbot" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

EXPOSE 80
EXPOSE 443

ENV UID=1000
ENV GID=1000

RUN apk update && \
    apk upgrade && \
    apk add nginx ca-certificates certbot && \
    rm -rf /var/cache/apk/* /etc/nginx/nginx.conf /etc/nginx/conf.d/* && \
    mkdir -p /var/run/nginx

COPY ./overlay /

VOLUME [ "/www", "/etc/nginx/conf.d", "/etc/nginx/modules", "/etc/nginx/sites" ]

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=5 CMD [ "/usr/bin/healthcheck" ]

RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

CMD [ "nginx" ]
