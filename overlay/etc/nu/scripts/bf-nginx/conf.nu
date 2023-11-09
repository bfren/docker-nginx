use bf

# Test nginx configuration
export def test [] {
    let ok = { bf write ok "Configuration OK." conf/test }
    { ^nginx -qt } | bf handle -s $ok conf/test
}
