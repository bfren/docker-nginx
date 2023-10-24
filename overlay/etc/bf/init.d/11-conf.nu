use bf
bf env load

# Generate nginx configuration files
def main [] {
    bf write "Generating nginx configuration files."
    generate "nginx.conf" (bf env NGINX_ETC)
    generate "nginx-base.conf" (bf env NGINX_ETC_HELPERS)
    generate "nginx-ignore-favicon.conf" (bf env NGINX_ETC_HELPERS)
}

# Generate a file with log output
def generate [
    filename: string    # The name of the file to generate (must exist within templates directory)
    output_dir: string  # The output directory to use
] {
    bf write debug $" .. ($filename)"
    bf esh $"(bf env ETC_TEMPLATES)/($filename).esh" $"($output_dir)/($filename)"
}
