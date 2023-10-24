use bf
bf env load

# Set environment variables
def main [] {
    let etc = "/etc/nginx"
    bf env set NGINX_ETC $etc
    bf env set NGINX_ETC_HELPERS $"($etc)/helpers"
    bf env set NGINX_ETC_MODULES $"($etc)/modules"
    bf env set NGINX_LOCALHOST_CONF $"($etc)/sites/localhost.conf"

    let log = "/var/log/nginx"
    bf env set NGINX_ACCESS_LOG $"($log)/access.log"
    bf env set NGINX_ERROR_LOG $"($log)/error.log"

    let www = "/www"
    bf env set NGINX_WWW $www
    bf env set NGINX_PUBLIC (bf env NGINX_PUBLIC_OVERRIDE $"($www)/public")

    # return nothing
    return
}
