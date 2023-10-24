use ch.nu
use write.nu

# Path to the environment variable store
const env_dir = "/etc/bf/env.d"

# bfren platform prefix for namespacing environment variables
const prefix = "BF_"

# Returns the value of an environment variable - if $default_value is not set and the variable does not exist,
# an error will be thrown
export def main [
    key: string         # Environment variable key - the BF_ prefix will be added automatically
    default_value?: any # Optional default value to use if the variable cannot be found
    --no-prefix (-P)    # Do not add the BF_ prefix
] {
    # add (or don't add!) the BF_ prefix
    let prefixed = if $no_prefix { $key } else { add_prefix $key }

    # return the value if it exists
    let value = safe --no-prefix $prefixed
    if $value != null {
        return $value
    }

    # return the default value if it is set
    if $default_value != null {
        return $default_value
    }

    # otherwise output with an error
    write error $"Unable to get environment variable ($prefixed)." env
}

# Adds the BF_ prefix to $key
def add_prefix [key: string] { $prefix + $key }

# Apply permissions for the environment variables directory -
# we do this in a separate shell so we don't get log output every time a variable is set
export def apply_perms [] { do { ^nu -c $"use bf ch ; [($env_dir) \"root:root\" 0666] | ch apply" } | ignore }

# Returns true if $key exists in the environment and is equal to 1
export def check [
    key: string         # Environment variable key - the BF_ prefix will be added automatically
    --no-prefix (-P)    # Do not add the BF_ prefix
] {
    # add (or don't add!) the BF_ prefix
    let prefixed = if $no_prefix { $key } else { add_prefix $key }

    # return whether or not the key value equals 1
    (safe --no-prefix $prefixed | into string) == "1"
}

# Returns true if the BF_DEBUG environment variable is set to 1
export def debug [] { check DEBUG }

# Hide and remove an environment variable
export def --env hide [
    key: string         # Environment variable key name - the BF_ prefix will be added automatically
    --no-prefix (-P)    # Do not add the BF_ prefix
] {
    # add (or don't add!) the BF_ prefix
    let prefixed = if $no_prefix { $key } else { add_prefix $key }

    # hide from the current environment
    hide-env --ignore-errors $prefixed

    # delete persistence file
    rm --force $"($env_dir)/($prefixed)"

    # output for debugging purposes
    # don't bother for BF_X - there are lots of these otherwise!
    if $key != "X" { write debug $"($prefixed) removed." env/hide }
}

# Load shared environment into the current $env
export def --env load [
    x_prefix?: string       # If $set_executable is added, $prefix will be added before the name of the current script
    --set-executable (-x)   # Whether or not to set BF_X to the current script
] {
    # these environment variables are reserved, set only by nu
    let ignore = [
        BF_X
        CURRENT_FILE
        FILE_PWD
    ]

    # load environment variables from shared directory
    ls -f $env_dir | get name | each {|x|
        {name: ($x | path basename | str upcase), path: $x}
    } | where {|x|
        $x.name not-in $ignore
    } | each {|x|
        open --raw $x.path | str trim | {$x.name: $in}
    } | reduce -f {} {|y, acc|
        $acc | merge $y
    } | load-env

    # set current script
    if $set_executable { x_set $x_prefix }
}

# Safely returns the value of an environment variable -
# if the variable doesn't exist, an empty string will be returned instead
export def safe [
    key: string         # Environment variable key - the BF_ prefix will be added automatically
    --no-prefix (-P)    # Do not add the BF_ prefix
] {
    # add (or don't add!) the BF_ prefix
    let prefixed = if $no_prefix { $key } else { add_prefix $key }

    # ignore errors when getting the variable
    $env | get --ignore-errors --sensitive ($prefixed)
}

# Save an environment variable to the bfren environment
export def --env set [
    key: string         # Environment variable key name - the BF_ prefix will be added automatically
    value: any          # Environment variable value
    --no-prefix (-P)    # Do not add the BF_ prefix
] {
    # add (or don't add!) the BF_ prefix
    let prefixed = if $no_prefix { $key } else { add_prefix $key }

    # save to current environment
    load-env {$prefixed: $value}

    # create persistence file
    $value | save --force $"($env_dir)/($prefixed)"
    apply_perms

    # output for debugging purposes
    # don't bother for BF_X - there are lots of these otherwise!
    if $key != "X" { write debug $"($prefixed)=($value)." env/set }
}

# Show all bfren platform environment variables
export def show [] {
    $env | transpose key value | where {|x| $x.key | str starts-with $prefix } | | transpose -i -r -d | print
}

# Store incoming environment variables
export def store [] {
    ^env | lines | parse "{key}={value}" | each {|x| $x.value | save --force $"($env_dir)/($x.key)" } | ignore
    apply_perms
}

# Clears the BF_X environment variable
export def --env x_clear [] { hide X }

# Gets the name of the currently executing script
export def x_get [
    x_prefix?: string # If set, will be added before the name of the current script
] {
    if $x_prefix != null { $"($x_prefix)/" } | $"($in)($env.CURRENT_FILE | path basename)"
}

# Sets the BF_X environment variable to the name of the currently executing script
export def --env x_set [
    x_prefix?: string # If set, will be added before the name of the current script
] {
    set X (x_get $x_prefix)
}
