# Nginx

![GitHub release (latest by date)](https://img.shields.io/github/v/release/bfren/docker-nginx) ![Docker Pulls](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fpulls%2Fnginx) ![Docker Image Size](https://img.shields.io/endpoint?url=https%3A%2F%2Fbfren.dev%2Fdocker%2Fsize%2Fnginx) ![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/bfren/docker-nginx/dev.yml?branch=main)

[Docker Hub](https://hub.docker.com/r/bfren/nginx) - [Quay.io](https://quay.io/repository/bfren/nginx) - [bfren ecosystem](https://github.com/bfren/docker)

## Introduction

A small, sensible [nginx](https://nginx.org) image for serving static files, or as the base for images that need a web server - [Nginx + PHP](https://github.com/bfren/docker-nginx-php), [WordPress](https://github.com/bfren/docker-wordpress), [Baikal](https://github.com/bfren/docker-baikal), [FreshRSS](https://github.com/bfren/docker-freshrss) and [Nginx + WebDAV](https://github.com/bfren/docker-nginx-webdav) are all built on it.

It is [Alpine + S6](https://github.com/bfren/docker-alpine-s6) with:

* nginx from Alpine's own packages, with the Brotli module (and zstd, on Alpine 3.20 and above)
* a ready-made configuration with zstd, Brotli and gzip compression, hidden version number and sensible defaults
* helper files you can include for static files, error pages, uploads and more
* log forwarding to `docker logs`, a daily configuration reload and a health check

There is no SSL support - it is designed to run behind a reverse proxy such as [Caddy](https://github.com/bfren/docker-caddy-proxy).

## Quickstart

Serve the files in `./site` on port 8080:

```sh
docker run -d --name web -p 8080:80 -v ./site:/www/public bfren/nginx
```

Or with Docker Compose:

```yaml
services:
  web:
    image: quay.io/bfren/nginx:nginx1.30-alpine3.24-7.3
    ports:
      - "8080:80"
    volumes:
      - ./site:/www/public
```

Open `http://localhost:8080`. If you don't mount anything, nginx serves a "Welcome to Nginx" page.

## Features

* 🪶 Alpine 3.15 to 3.24, each with its own nginx version - choose with the image tag
* 🗜️ zstd (Alpine 3.20 and above), Brotli and gzip compression, with pre-compressed `.gz` and `.br` files served as they are
* 🔒 `server_tokens off`, and nginx workers run as a non-root `www` user
* 🧩 Include-based configuration: add your own sites, server snippets, modules and `http` settings without replacing `nginx.conf`
* 📜 Error log always forwarded to `docker logs`, access log optionally
* 🔁 Configuration tested at start-up, and reloaded every day at 02:00
* 🩺 Health check that loads a URI of your choice (set `BF_NGINX_HEALTHCHECK_URI`)
* 🧪 Built-in test runner (from [Alpine](https://github.com/bfren/docker-alpine))

## Tags

Images are published to Docker Hub (`bfren/nginx`) and Quay.io (`quay.io/bfren/nginx`) for `linux/amd64`, `linux/arm/v7` and `linux/arm64`. Tags include the nginx version, because the version depends on the Alpine release.

| Tag                            | Example                        | Use when                                                  |
| ------------------------------ | ------------------------------ | --------------------------------------------------------- |
| `nginxX.Y-alpineA.B`           | `nginx1.30-alpine3.24`         | You want the latest image for an nginx and Alpine version |
| `nginxX.Y-alpineA.B-MAJOR`     | `nginx1.30-alpine3.24-7`       | You want updates, but not breaking changes                |
| `nginxX.Y-alpineA.B-MINOR`     | `nginx1.30-alpine3.24-7.3`     | You want fixes only - **recommended for building on**     |
| `nginxX.Y-alpineA.B-VERSION`   | `nginx1.30-alpine3.24-7.3.0`   | You want to pin this image exactly                        |
| `nginxX.Y.Z-alpineA.B`         | `nginx1.30.4-alpine3.24`       | You want an exact nginx release                           |
| `nginxX.Y.Z-alpineA.B-VERSION` | `nginx1.30.4-alpine3.24-7.3.0` | You want to pin both                                      |
| `latest`, `7`, `7.3`, `7.3.0`  |                                | As above, on the newest Alpine version                    |
| `nginxX.Y`, `nginxX.Y.Z`       | `nginx1.30`, `nginx1.30.4`     | As above, on the newest Alpine version                    |

| Alpine | nginx | Alpine security support ends |
| ------ | ----- | ---------------------------- |
| 3.24   | 1.30  | 2028-06-01                   |
| 3.23   | 1.28  | 2027-11-01                   |
| 3.22   | 1.28  | 2027-05-01                   |
| 3.21   | 1.26  | 2026-11-01                   |
| 3.20   | 1.26  | ended 2026-04-01             |
| 3.19   | 1.24  | ended 2025-11-01             |
| 3.18   | 1.24  | ended 2025-05-09             |
| 3.17   | 1.22  | ended 2024-11-22             |
| 3.16   | 1.22  | ended 2024-05-23             |
| 3.15   | 1.20  | ended 2023-11-01             |

Images for unsupported Alpine versions are still built, but no longer receive Alpine security fixes - avoid them for anything new.

## Configuration

### Ports

| Port | Purpose                                            |
| ---- | -------------------------------------------------- |
| `80` | HTTP - put a reverse proxy in front of it for SSL. |

### Volumes

| Volume | Purpose                                                                                                       |
| ------ | ------------------------------------------------------------------------------------------------------------- |
| `/www` | Files in `/www/public` are served by nginx. If `/www/public` doesn't exist it is created with a welcome page. |

### Environment Variables

| Variable                      | Values   | Description                                                                             | Default            |
| ----------------------------- | -------- | --------------------------------------------------------------------------------------- | ------------------ |
| `BF_NGINX_FORWARD_ACCESS_LOG` | `0`, `1` | Forward the access log to `docker logs` (the error log is always forwarded).            | `0`                |
| `BF_NGINX_HEALTHCHECK_URI`    | URI      | The URI loaded by the health check.                                                     | `http://localhost` |
| `BF_NGINX_IGNORE_FAVICON`     | `0`, `1` | Return `204 No Content` for a missing `favicon.ico`, instead of a 404 in the error log. | `1`                |
| `BF_NGINX_PUBLIC_OVERRIDE`    | path     | Serve files from this directory instead of `/www/public`.                               | *blank*            |
| `BF_DEBUG`                    | `0`, `1` | Show detailed output from `bf` scripts.                                                 | `0`                |

Alpine + S6 adds [more variables](https://github.com/bfren/docker-alpine-s6#environment-variables) (timezone, cron).

## How It Works

### Starting

When the container starts, [Alpine + S6](https://github.com/bfren/docker-alpine-s6#starting) runs the initialisation scripts, then S6 starts three services:

| Service            | Does                                                                                                                        |
| ------------------ | --------------------------------------------------------------------------------------------------------------------------- |
| `nginx`            | Tests the configuration, then runs nginx in the foreground.                                                                 |
| `nginx-error-log`  | Forwards `/var/log/nginx/error.log` to `docker logs`.                                                                       |
| `nginx-access-log` | Forwards `/var/log/nginx/access.log` to `docker logs` - only if `BF_NGINX_FORWARD_ACCESS_LOG=1`, otherwise it stops itself. |

The image's initialisation scripts (`10-env`, `11-conf`, `12-public`) set the nginx environment variables, generate the configuration files below from templates, and create the public directory if it doesn't exist.

If the configuration test fails, nginx doesn't start and the container stops - see `docker logs` for the error.

### Configuration files

`nginx.conf` is generated at start-up from a template, so it picks up your environment variables. You normally don't edit it - add to it using these directories instead:

| Directory            | Included in                  | Use for                                                              |
| -------------------- | ---------------------------- | -------------------------------------------------------------------- |
| `/etc/nginx/modules` | the main context             | `load_module` lines for extra modules.                               |
| `/etc/nginx/http.d`  | the `http` block             | Settings that apply to every site, e.g. `map` blocks or rate limits. |
| `/etc/nginx/sites`   | the `http` block             | One `server { … }` file per site.                                    |
| `/etc/nginx/custom`  | the default `localhost` site | Extra directives for the default site, e.g. a `location` block.      |

The default site, `sites/localhost.conf`, is a single `server` block that serves `/www/public` on port 80. Add your own `.conf` files to `sites`, or map a file over `localhost.conf` to replace it.

nginx's own `/etc/nginx` files are owned by the `www` user and made read-only at start-up (see `ch.d` in [Alpine + S6](https://github.com/bfren/docker-alpine-s6#permissions-chd)), so mounted configuration files must be readable by `www`.

### Helper files

Include these in a `server` block with `include helpers/<name>;` (the path is relative to `/etc/nginx`):

| Helper                | Description                                                                                                                         |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `base.conf`           | Generated at start-up. Listens on port 80 (IPv4 and IPv6) as the default server and sets the document root.                         |
| `discworld.conf`      | Adds the [GNU Terry Pratchett](http://www.gnuterrypratchett.com/) header.                                                           |
| `error-pages.conf`    | Use nginx's default error page for 500, 502, 503 and 504 errors.                                                                    |
| `ignore-favicon.conf` | Generated at start-up. Returns 204 for a missing `favicon.ico` and keeps it out of the logs - empty if `BF_NGINX_IGNORE_FAVICON=0`. |
| `static-files.conf`   | Sets a 365 day expiry, a public cache header and turns off logging for static file types (images, CSS, JavaScript, fonts, video).   |
| `uploads.conf`        | Sets `client_max_body_size 0`, so there is no limit on upload size.                                                                 |

### Compression

Text responses are compressed with zstd, Brotli or gzip, depending on what the browser accepts. This happens on the fly for every request - nginx doesn't cache the compressed result. zstd is only installed on Alpine 3.20 and above, because older releases don't have the module; there, responses use Brotli or gzip. Compression levels are 6 for gzip and Brotli, and 3 for zstd. Responses smaller than 256 bytes are not compressed. Only gzip and Brotli have pre-compressed file support (below); zstd is always compressed on the fly.

To avoid that cost for static files, compress them when you build your site: put a `.br` (`brotli -k -q 11 file`) and/or a `.gz` (`gzip -k -9 file`) next to each file, and nginx serves them directly. `brotli_static` and `gzip_static` are both on, and they only take effect when a pre-compressed file exists.

### Logs

nginx writes to `/var/log/nginx/access.log` and `error.log`. The error log is always forwarded to `docker logs`. Set `BF_NGINX_FORWARD_ACCESS_LOG=1` to forward the access log too - it's off by default so that a busy site doesn't flood the container's log.

### Reloading

`nginx-reload` tests the configuration and, if it is valid, reloads nginx without dropping connections. It does nothing if nginx isn't running. It runs automatically every day at 02:00 (so, for example, renewed certificates or changed files are picked up), and you can run it yourself:

```sh
docker exec <container> nginx-reload
```

### Health check

`healthcheck` loads `BF_NGINX_HEALTHCHECK_URI` and passes if the HTTP status is between 200 and 399. Docker runs it every 30 seconds (every 2 seconds during the first 60 seconds, so a new container reports healthy quickly). Use another URI for sites where `/` isn't a good test - for example, [WordPress](https://github.com/bfren/docker-wordpress) uses its login page.

### The `bf-nginx` module

| Command              | Use                                                                |
| -------------------- | ------------------------------------------------------------------ |
| `bf-nginx conf test` | Test the nginx configuration and report whether it is valid.       |
| `bf-nginx reload`    | Test the configuration, then reload nginx - only if it is running. |

Load it with `use bf-nginx`. The executables `nginx-reload` and `bf-healthcheck` are in `/usr/bin/bf` and on the `PATH`, and `bf-healthcheck` is also available as `healthcheck`.

## Building on this image

```dockerfile
FROM quay.io/bfren/nginx:nginx1.30-alpine3.24-7.3

COPY ./overlay /
RUN bf-install
```

Put site configuration in `overlay/etc/nginx/sites`, extra settings in `overlay/etc/nginx/http.d` and `overlay/etc/nginx/custom`, and any installation steps in `overlay/tmp/install`. Replace `overlay/usr/bin/bf/bf-healthcheck` to change the health check. See [Alpine](https://github.com/bfren/docker-alpine) and [Alpine + S6](https://github.com/bfren/docker-alpine-s6) for everything else.

## Testing

```sh
./test.nu        # builds the image and runs /test
./test.nu --all  # every version, in parallel
```

`/test` runs this image's tests - the configuration check, the generated `nginx.conf` (compression settings, and zstd only where the module is installed) and `nginx-reload` - alongside the base images' tests, and fails if tests don't execute. Run it on more than one Alpine version, e.g. `./test.nu 3.19` and `./test.nu 3.24`, as zstd is only installed from 3.20.

## Troubleshooting

### The container stops straight after starting

nginx's configuration test failed. Run `docker logs <container>` - nginx names the file and line. Common causes are a mounted `.conf` file that `www` can't read, or a missing `include` file.

### I get a 404 for everything

nginx serves `/www/public`, not `/www`. Mount your files at `/www/public`, or set `BF_NGINX_PUBLIC_OVERRIDE`.

### Changes to my configuration don't take effect

Run `docker exec <container> nginx-reload`, or restart the container. `nginx.conf`, `base.conf` and `ignore-favicon.conf` are regenerated from templates every time the container starts, so don't edit them - add to `http.d`, `sites` or `custom` instead.

### I can't see access logs in `docker logs`

Set `BF_NGINX_FORWARD_ACCESS_LOG=1`. They are always written to `/var/log/nginx/access.log` inside the container.

### The health check fails

The URI in `BF_NGINX_HEALTHCHECK_URI` must return a 2xx or 3xx status from inside the container. Test it with `docker exec <container> healthcheck`.

## FAQs

### Why no SSL?

SSL is better handled once, by a reverse proxy in front of all your containers, than in each one. [Caddy](https://github.com/bfren/docker-caddy-proxy) does it automatically.

### Can I run PHP?

Use [Nginx + PHP](https://github.com/bfren/docker-nginx-php), which is built on this image and runs PHP-FPM.

### Why do the tags include the nginx version?

nginx comes from Alpine's packages, so each Alpine release has a different version. The tag tells you exactly which you get, and `nginxX.Y.Z-alpineA.B-VERSION` pins both.

## Licence

> [MIT](https://mit.bfren.dev/2020)

## Copyright

> Copyright (c) 2020-2026 [bfren](https://bfren.dev) (unless otherwise stated)
