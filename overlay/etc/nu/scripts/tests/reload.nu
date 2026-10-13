use std/assert
use ../bf-nginx/reload.nu

# Run a closure with a `pidof` that never finds a process (and exits with 1, like the real one does)
# tests run in parallel, and other tests start nginx to check configuration, so the real `pidof` cannot be relied on
def with_no_nginx_process [action: closure] {
    let dir = mktemp --directory
    let stub = $"($dir)/pidof"
    "#!/bin/sh\nexit 1\n" | save $stub
    ^chmod +x $stub

    with-env {PATH: ($env.PATH | prepend $dir)} { do $action }
}


#======================================================================================================================
# main
#======================================================================================================================

export def main__does_nothing_when_nginx_is_not_running [] {
    # should return without error - pidof exits with 1 when nothing is found
    let result = with_no_nginx_process { reload }

    assert ($result | is-empty) "reload should not return anything"
}
