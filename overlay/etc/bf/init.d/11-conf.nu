use bf
bf env load

# Generate nginx configuration files
def main [] {
    bf write "Generating nginx configuration files."
    bf esh template $"(bf env NGINX_ETC)/nginx.conf"
    bf esh template $"(bf env NGINX_ETC_HELPERS)/base.conf"
    bf esh template $"(bf env NGINX_ETC_HELPERS)/ignore-favicon.conf"
}
