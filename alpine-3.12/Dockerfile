FROM bcgdesign/alpine-s6:alpine-3.12-1.3.0

LABEL maintainer="Ben Green <ben@bcgdesign.com>" \
    org.label-schema.name="Nginx" \
    org.label-schema.version="Alpine 3.12" \
    org.label-schema.vendor="Ben Green" \
    org.label-schema.schema-version="1.0"

# fix for creating S6-compatible Nginx logs
RUN s6-rmrf /etc/s6/services/s6-fdholderd/down

EXPOSE 80

COPY ./alpine-3.12/NGINX_BUILD /tmp/NGINX_BUILD
RUN export NGINX_VERSION=$(cat /tmp/NGINX_BUILD) \
    && echo "Nginx v${NGINX_VERSION}" \
    && addgroup --gid 1000 www \
    && adduser --uid 1000 --no-create-home --disabled-password --ingroup www www \
    && apk -U upgrade \
    && apk add \
        ca-certificates \
        nginx=${NGINX_VERSION} \
    && rm -rf /var/cache/apk/* /etc/nginx/nginx.conf /etc/nginx/conf.d/* /var/www/* /tmp/* \
    && mkdir -p /var/run/nginx

COPY ./overlay /

RUN ln -s /www /var/www/localhost
VOLUME [ "/www" ]

HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=5 CMD [ "healthcheck" ]
