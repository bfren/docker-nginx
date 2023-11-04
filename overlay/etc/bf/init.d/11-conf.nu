use bf
bf env load

# Generate nginx configuration files
def main [] {
    bf write "Generating nginx configuration files."
    bf esh template "nginx.conf" (bf env NGINX_ETC)
    bf esh template "base.conf" (bf env NGINX_ETC_HELPERS)
    bf esh template "ignore-favicon.conf" (bf env NGINX_ETC_HELPERS)
}
