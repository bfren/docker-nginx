# Docker Nginx

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx) ![Docker Pulls](https://img.shields.io/docker/pulls/bfren/nginx?label=pulls) ![Docker Image Size (tag)](https://img.shields.io/docker/image-size/bfren/nginx/latest?label=size)<br/>
![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx/dev-1_18?label=Nginx+1.18) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx/dev-1_20?label=Nginx+1.20) ![GitHub Workflow Status](https://img.shields.io/github/workflow/status/bfren/docker-nginx/dev-edge?label=edge)

[Docker Repository](https://hub.docker.com/r/bfren/nginx) - [bfren ecosystem](https://github.com/bfren/docker)

A simple Nginx base image - no SSL support etc, designed to be used behind a proxy server.

## Contents

* [Ports](#ports)
* [Volumes](#volumes)
* [Environment Variables](#environment-variables)
* [Helper Functions](#helper-functions)
* [Nginx Configuration Helpers](#nginx-configuration-helpers)
* [Licence / Copyright](#licence)

## Ports

* 80

## Volumes

| Volume | Purpose                                                                                                       |
| ------ | ------------------------------------------------------------------------------------------------------------- |
| `/www` | Files in this directory will be served by Nginx (if not mapped, a 'Welcome to Nginx' message will be served). |

## Environment Variables

| Variable               | Values | Description                                                                                                        | Default |
| ---------------------- | ------ | ------------------------------------------------------------------------------------------------------------------ | ------- |
| `NGINX_IGNORE_FAVICON` | 0 or 1 | If 1, a helper configuration file will contain a directive to return 204 (No Content) when a favicon is requested. | 1       |

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

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2022 [bfren](https://bfren.dev) (unless otherwise stated)
