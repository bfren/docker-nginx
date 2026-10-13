use std/assert
use ../bf-nginx/reload.nu

# Tests run in a container where nginx has not been started
def assert_nginx_not_running [] {
    let pid = ^pidof nginx | complete | get stdout | str trim
    assert ($pid | is-empty) "nginx should not be running in the test container"
}


#======================================================================================================================
# main
#======================================================================================================================

export def main__does_nothing_when_nginx_is_not_running [] {
    assert_nginx_not_running

    # should return without error - pidof exits with 1 when nothing is found
    let result = reload

    assert ($result | is-empty) "reload should not return anything"
}
