# Docker Nginx

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bencgreen/docker-nginx) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bencgreen/docker-nginx/build?label=github) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/bcgdesign/nginx?label=docker) ![Docker Pulls](https://img.shields.io/docker/pulls/bcgdesign/nginx?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bcgdesign/nginx/latest?label=size)

[Docker Repository](https://hub.docker.com/r/bcgdesign/nginx) - [bcg|design ecosystem](https://github.com/bencgreen/docker)

A simple Nginx base image - no SSL support etc, designed to be used behind a proxy server.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Helper Functions](#helper-functions)
* [Nginx Configuration Helpers](#nginx-configuration-helpers)
* [Authors / Licence / Copyright](#authors)

## Ports

* 80

## Volumes

| Volume | Purpose                                                                                                      |
| ------ | ------------------------------------------------------------------------------------------------------------ |
| `/www` | Files in this directory will be served by Nginx (if not mapped, a 'Welcome to Nginx' message will be served) |

## Helper Functions

| Function       | Arguments | Description                                                            | Usage                                    |
| -------------- | --------- | ---------------------------------------------------------------------- | ---------------------------------------- |
| `nginx-reload` | *None*    | Tests Nginx configuration and if successful, reloads the Nginx server. | `docker exec <<CONTAINER>> nginx-reload` |

## Nginx Configuration Helpers

The image contains a handful of useful Nginx configuration 'helper' files, which you can find in `/overlay/etc/nginx/helpers`.  They all begin with the prefix 'nginx':

| Helper                 | Description                                                                                                                         |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `-base.conf`           | Basic configuration, sets listen port, document root, and adds the [GNU Terry Pratchett](http://www.gnuterrypratchett.com/) header. |
| `-ignore-favicon.conf` | Returns 204 for favicon.ico requests that do not exist, and stops it being added to the error log.                                  |
| `-error-pages.conf`    | Include if you want to use Nginx's default error pages.                                                                             |
| `-static-files.conf`   | Sets useful headers, cache, and expiration values for serving static files.                                                         |
| `-uploads.conf`        | Sets `client_max_body_size` to 0 - so there is no limit on file upload size.                                                        |

## Authors

* [Ben Green](https://github.com/bencgreen)

## License

> MIT

## Copyright

> Copyright (c) 2021 Ben Green <https://bcgdesign.com>
> Unless otherwise stated
