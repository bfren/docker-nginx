use bf

# Test nginx configuration
export def test [] { { ^nginx -qt } | bf handle }
