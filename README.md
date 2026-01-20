# Docker Nginx

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-nginx/dev.yml?branch=main)

[Docker Repository](https://hub.docker.com/r/bfren/nginx) - [bfren ecosystem](https://github.com/bfren/docker)

A simple Nginx base image - no SSL support etc, designed to be used behind a proxy server.

Files are served from /www/public (which can be overridden using BF_NGINX_PUBLIC_OVERRIDE).

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

| Volume | Purpose                                                                                                   |
| ------ | --------------------------------------------------------------------------------------------------------- |
| `/www` | Files in this directory are served by Nginx (if not mapped, a 'Welcome to Nginx' message will be served). |

## Environment Variables

| Variable                      | Values | Description                                                                                                        | Default            |
| ----------------------------- | ------ | ------------------------------------------------------------------------------------------------------------------ | ------------------ |
| `BF_NGINX_FORWARD_ACCESS_LOG` | 0 or 1 | If 1, the access log will be forwarded to Docker's stdout.                                                         | 0                  |
| `BF_NGINX_HEALTHCHECK_URI`    | URI    | The URI to load during the healthcheck.                                                                            | http://localhost   |
| `BF_NGINX_IGNORE_FAVICON`     | 0 or 1 | If 1, a helper configuration file will contain a directive to return 204 (No Content) when a favicon is requested. | 1                  |
| `BF_NGINX_PUBLIC_OVERRIDE`    | string | If set, it will be used as the nginx root directory (which by default is /www).                                    | *blank*            |

## Helper Functions

| Function       | Arguments | Description                                                            | Usage                                    |
| -------------- | --------- | ---------------------------------------------------------------------- | ---------------------------------------- |
| `healthcheck`  | *None*    | Loads BF_NGINX_HEALTHCHECK_URI to check everything is working.            | `docker exec <<CONTAINER>> healthcheck`  |
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

> Copyright (c) 2020-2026 [bfren](https://bfren.dev) (unless otherwise stated)
