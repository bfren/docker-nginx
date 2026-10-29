use std/assert


#======================================================================================================================
# helpers
#======================================================================================================================

# Copy /etc/nginx to a temporary directory, generate nginx.conf from the template there, and return its details -
# tests run in parallel, so this must never touch the real configuration
def render []: nothing -> record<dir: string, conf: string> {
    let dir = mktemp --directory
    ^cp -a /etc/nginx/. $dir

    let conf = $"($dir)/nginx.conf"
    let vars = {
        BF_NGINX_ERROR_LOG: $"($dir)/error.log"
        BF_NGINX_ACCESS_LOG: $"($dir)/access.log"
    }
    with-env $vars { ^esh -o $conf /etc/bf/templates/nginx.conf.esh }

    {dir: $dir, conf: $conf}
}


#======================================================================================================================
# install
#======================================================================================================================

export def install__adds_zstd_module [] {
    let result = ^apk info -e nginx-mod-http-zstd | complete

    assert equal 0 $result.exit_code "the zstd module is not installed"
}


#======================================================================================================================
# generated configuration
#======================================================================================================================

export def generated__is_valid_nginx_configuration [] {
    let r = render

    let result = ^nginx -t -c $r.conf | complete

    assert equal 0 $result.exit_code $"nginx -t failed: ($result.stderr)"
}

export def generated__sets_minimum_length_for_gzip_and_brotli [] {
    let conf = render | get conf | open --raw $in

    assert ($conf =~ 'gzip_min_length\s+256;') "gzip_min_length is missing"
    assert ($conf =~ 'brotli_min_length\s+256;') "brotli_min_length is missing"
}

export def generated__enables_static_gzip_and_brotli [] {
    let conf = render | get conf | open --raw $in

    assert ($conf =~ 'gzip_static\s+on;') "gzip_static is not on"
    assert ($conf =~ 'brotli_static\s+on;') "brotli_static is not on"
}

export def generated__sets_minimum_length_for_zstd [] {
    let conf = render | get conf | open --raw $in

    assert ($conf =~ 'zstd_min_length\s+256;') "zstd_min_length is missing"
}


#======================================================================================================================
# checked-in configuration
#======================================================================================================================

export def default__sets_minimum_length_and_static_files [] {
    let conf = open --raw /etc/nginx/nginx.conf

    assert ($conf =~ 'gzip_min_length\s+256;') "gzip_min_length is missing"
    assert ($conf =~ 'brotli_min_length\s+256;') "brotli_min_length is missing"
    assert ($conf =~ 'gzip_static\s+on;') "gzip_static is not on"
}
