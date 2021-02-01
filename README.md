# Docker Nginx

![Docker Image Version (tag latest semver)](https://img.shields.io/docker/v/bcgdesign/nginx/latest?label=latest) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/build?label=github) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/nginx) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

A simple Nginx base image - no SSL support etc, designed to be used behind a proxy server.

## Ports

* 80

## Volumes

| Volume | Purpose                                                                                                      |
| ------ | ------------------------------------------------------------------------------------------------------------ |
| `/www` | Files in this directory will be served by Nginx (if not mapped, a 'Welcome to Nginx' message will be served) |

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>  
> Unless otherwise stated
