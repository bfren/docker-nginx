use bf
use conf.nu

export def preflight [] {
    # load environment
    bf env load

    # manually set executing script
    bf env set X nginx/run

    # Test nginx configuration
    conf test

    # if we get here we are ready to start nginx
    bf write "Starting nginx in foreground mode."
}
