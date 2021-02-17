FROM bcgdesign/alpine-s6:alpine-3.12-1.5.0

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx" \
    org.label-schema.version="Alpine 3.12" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

# fix for creating S6-compatible Nginx logs
RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

EXPOSE 80

COPY ./overlay /
COPY ./alpine-3.12/NGINX_BUILD /tmp/NGINX_BUILD

RUN bcg-install

VOLUME [ "/www" ]
