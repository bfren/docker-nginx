use bf

# Test nginx configuration
export def test [] {
    let result = do { ^nginx -qt } | complete
    if $result.exit_code > 0 { bf write error --code $result.exit_code $result.stderr }
}
