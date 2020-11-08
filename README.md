# Docker Nginx

![build](https://github.com/bencgreen/docker-nginx/workflows/build/badge.svg)

[Docker Repository](https://hub.docker.com/r/bcgdesign/nginx)

A simple Nginx base image - no SSL support etc, designed to be used behind a proxy server.

## Ports

* 80

## Volumes

* `/www` - these files will be served by Nginx
* `/etc/nginx/conf.d` - custom Nginx configuration
* `/etc/nginx/modules` - Nginx modules
* `/etc/nginx/sites` - server definitions

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2020 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated
