use bf
bf env load

# Ensure the public directory exists
def main [] {
    let public = $"(bf env NGINX_PUBLIC)"

    # if the directory already exists do nothing
    if ($public | path exists) {
        bf write $"($public) already exists."
        return
    }

    # $public does not exist, so create it and copy the default index file
    bf write $"Creating ($public)."
    mkdir $public
    cp $"(bf env ETC_SRC)/index.html" $public
    bf ch apply_file "11-nginx-www"

    # return nothing
    return
}
