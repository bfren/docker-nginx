use bf
bf env load

# Ensure the public directory exists
def main [] {
    let public = $"(bf env NGINX_WWW)/public"

    # if the directory already exists do nothing
    if ($public | path exists) {
        bf write $"($public) already exists."
        return
    }

    # if /www is empty, create /www/public and copy the default index file
    if (ls (bf env NGINX_WWW) | length) == 0 {
        bf write $"Creating ($public)."
        mkdir $public
        cp $"(bf env ETC_SRC)/index.html" $public
        bf ch apply_file "11-nginx-www"
        return
    }
}
