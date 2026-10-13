use std/assert
use ../bf-nginx/conf.nu *


#======================================================================================================================
# test
#======================================================================================================================

export def test__succeeds_for_default_configuration [] {
    # `nginx -qt` is quiet on success, and `bf handle` throws an error on failure
    let result = test

    assert ($result | is-empty) "conf test should not output anything on success"
}
