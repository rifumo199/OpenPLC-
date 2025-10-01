#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get the directory where the script is located
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Define potential locations for the OpenPLC start script
POSSIBLE_PATHS=(
    "$SCRIPT_DIR/OpenPLC_v3/start_openplc.sh"
    "$SCRIPT_DIR/OpenPLC/OpenPLC_v3/start_openplc.sh"
    "$SCRIPT_DIR/start_openplc.sh"
)

# Find the first valid script path
for path in "${POSSIBLE_PATHS[@]}"; do
    echo "🔎 Checking for script at: $path"
    if [ -x "$path" ]; then
        TARGET_SCRIPT="$path"
        break
    fi
done

# If no script was found, exit with an error
if [ -z "$TARGET_SCRIPT" ]; then
    echo "❌ Error: Could not find an executable 'start_openplc.sh'." >&2
    echo "   Searched in the following locations:" >&2
    printf "   - %s\n" "${POSSIBLE_PATHS[@]}" >&2
    echo >&2 # Add a blank line for readability
    echo "💡 Hint: For some projects, you may need to run an 'install.sh' script first." >&2
    exit 1
fi

echo "🚀 Launching OpenPLC from source..."
exec "$TARGET_SCRIPT" "$@"
