use bf
use bf-s6
bf env load

# Generate nginx configuration files
def main [] {
    bf write "Generating nginx configuration files."
    bf-s6 esh template $"(bf env NGINX_ETC)/nginx.conf"
    bf-s6 esh template $"(bf env NGINX_ETC_HELPERS)/base.conf"
    bf-s6 esh template $"(bf env NGINX_ETC_HELPERS)/ignore-favicon.conf"
}
