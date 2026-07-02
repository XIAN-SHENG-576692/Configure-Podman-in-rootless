#!/bin/bash

TARGET_DIR="$HOME/.config/Code/User"
TARGET_FILE="$TARGET_DIR/settings.json"

# Create directory if it does not exist
mkdir -p "$TARGET_DIR"

# Create an empty JSON file if it doesn't exist or is empty
if [ ! -f "$TARGET_FILE" ] || [ ! -s "$TARGET_FILE" ]; then
    echo "{}" > "$TARGET_FILE"
fi

# Use native Python 3 to parse and safely inject the setting
python3 -c "
import json
import os

path = os.path.expanduser('$TARGET_FILE')

try:
    with open(path, 'r', encoding='utf-8') as f:
        data = json.load(f)
except Exception:
    data = {}

data['dev.containers.dockerPath'] = 'podman'

with open(path, 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=4, ensure_ascii=False)
"

echo "Successfully updated VS Code settings on Linux."