#!/bin/sh
set -e

# Ensure key_usage.json exists as a file (not a directory)
# Docker creates a directory when mounting a non-existent file, so we handle that case
if [ -d /app/key_usage.json ]; then
    # Docker created a directory because the file didn't exist on host - remove it and create file
    rmdir /app/key_usage.json 2>/dev/null || rm -rf /app/key_usage.json
    echo "{}" > /app/key_usage.json
elif [ ! -f /app/key_usage.json ]; then
    # File doesn't exist at all - create it
    echo "{}" > /app/key_usage.json
fi

# Execute the main command
exec "$@"
