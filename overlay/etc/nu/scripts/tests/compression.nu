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

# Returns true if the zstd module is installed (it is not available on Alpine 3.19 and earlier)
def has_zstd []: nothing -> bool {
    (^apk info -e nginx-mod-http-zstd | complete | get exit_code) == 0
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

    assert ($conf | str contains "gzip_min_length                 256;") "gzip_min_length is missing"
    assert ($conf | str contains "brotli_min_length               256;") "brotli_min_length is missing"
}

export def generated__enables_static_gzip_and_brotli [] {
    let conf = render | get conf | open --raw $in

    assert ($conf | str contains "gzip_static                     on;") "gzip_static is not on"
    assert ($conf | str contains "brotli_static                   on;") "brotli_static is not on"
}

export def generated__includes_zstd_only_when_module_is_installed [] {
    let conf = render | get conf | open --raw $in

    let has_directives = $conf | str contains "zstd_min_length                 256;"

    assert equal (has_zstd) $has_directives "zstd directives should be present if, and only if, the module is installed"
}


#======================================================================================================================
# checked-in configuration
#======================================================================================================================

export def default__sets_minimum_length_and_static_files [] {
    let conf = open --raw /etc/nginx/nginx.conf

    assert ($conf | str contains "gzip_min_length                 256;") "gzip_min_length is missing"
    assert ($conf | str contains "brotli_min_length               256;") "brotli_min_length is missing"
    assert ($conf | str contains "gzip_static                     on;") "gzip_static is not on"
}
