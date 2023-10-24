use bf
use conf.nu

# Reload Nginx - but only if it is running
export def main [] {
    # get the pid of the nginx process
    let pid = ^pidof nginx

    # if the pid is empty, nginx is not running
    if $pid == "" {
        bf write debug "Nginx is not running." reload
        return
    }

    # nginx is running so test configuration in case there have been changes and then reload
    # Flags:
    #   -q  suppress non-error messages during testing
    #   -t  test Nginx configuration file(s)
    #   -s  send a signal to the master process (reload: reload configuration, start new worker process, shut down old one)
    bf write "Reloading nginx." reload
    cont test
    ^nginx -s reload
}
