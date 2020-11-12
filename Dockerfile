FROM bcgdesign/alpine-s6:1.0.4

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx" \
    org.label-schema.version="latest" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

EXPOSE 80

COPY ./VERSION /tmp/VERSION
RUN export NGINX_VERSION=$(cat /tmp/VERSION) \
    && echo "Nginx v${NGINX_VERSION}" \
    && addgroup --gid 1000 www \
    && adduser --uid 1000 --no-create-home --disabled-password --ingroup www www \
    && apk -U upgrade \
    && apk add \
        nginx=${NGINX_VERSION} \
        ca-certificates \
    && rm -rf /var/cache/apk/* /etc/nginx/nginx.conf /etc/nginx/conf.d/* /tmp/* \
    && mkdir -p /var/run/nginx

COPY ./overlay /

VOLUME [ "/www", "/etc/nginx/conf.d", "/etc/nginx/modules", "/etc/nginx/sites" ]

RUN chmod +x /usr/bin/healthcheck
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=5 CMD [ "/usr/bin/healthcheck" ]

RUN s6-rmrf /etc/s6/services/s6-fdholderd/down
