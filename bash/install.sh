#!/bin/bash

# Check if running as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root (use sudo)." >&2
    exit 1
fi

# Validate arguments
if [ $# -lt 1 ]; then
    echo "Usage: sudo ./install.sh <script_name> [alias_name] [target_dir]" >&2
    echo "Example: sudo ./install.sh my_script my_alias /usr/local/bin" >&2
    exit 1
fi

SCRIPT_NAME="$1"
ALIAS_NAME="${2:-$SCRIPT_NAME}"  # Default alias to script name if not provided
TARGET_DIR="${3:-/usr/local/bin}"  # Default to /usr/local/bin if not provided

# Check if the script exists
if [ ! -f "$SCRIPT_NAME" ]; then
    echo "Error: Script '$SCRIPT_NAME' not found." >&2
    exit 1
fi

# Copy the script to the target directory
echo "Installing '$SCRIPT_NAME' to '$TARGET_DIR'..."
cp "$SCRIPT_NAME" "$TARGET_DIR/$SCRIPT_NAME" || {
    echo "Failed to copy script to '$TARGET_DIR'." >&2
    exit 1
}

# Set execute permissions
chmod +x "$TARGET_DIR/$SCRIPT_NAME" || {
    echo "Failed to set execute permissions." >&2
    exit 1
}

# Create alias (optional)
if [ "$ALIAS_NAME" != "$SCRIPT_NAME" ]; then
    echo "Creating alias '$ALIAS_NAME' for '$SCRIPT_NAME'..."
    SHELL_CONFIG="$HOME/.bashrc"
    if [ -f "$HOME/.zshrc" ]; then
        SHELL_CONFIG="$HOME/.zshrc"
    fi

    echo "alias $ALIAS_NAME='$SCRIPT_NAME'" >> "$SHELL_CONFIG" || {
        echo "Failed to create alias in '$SHELL_CONFIG'." >&2
        exit 1
    }

    echo "Alias added to '$SHELL_CONFIG'. Run 'source $SHELL_CONFIG' to apply."
fi

echo "Installation complete. You can now run '$SCRIPT_NAME' or '$ALIAS_NAME' from anywhere."
