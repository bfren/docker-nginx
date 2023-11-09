use bf

# Test nginx configuration
export def test [] { { ^nginx -qt } | bf handle -s {|x| bf write ok "OK." conf/test } conf/test }
