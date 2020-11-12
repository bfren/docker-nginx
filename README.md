# Docker Nginx

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/bcgdesign/nginx/latest?label=latest&sort=semver) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/build?label=github) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx/latest?label=size)

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
