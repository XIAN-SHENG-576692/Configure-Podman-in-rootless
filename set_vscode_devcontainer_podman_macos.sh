#!/bin/bash

TARGET_DIR="$HOME/Library/Application Support/Code/User"
TARGET_FILE="$TARGET_DIR/settings.json"

# Create directory if it does not exist
mkdir -p "$TARGET_DIR"

# Create an empty JSON file if it doesn't exist
if [ ! -f "$TARGET_FILE" ] || [ ! -s "$TARGET_FILE" ]; then
    echo "{}" > "$TARGET_FILE"
fi

# Use native macOS JavaScript engine to safely update the JSON
osascript -l JavaScript <<EOF
var fm = $.NSFileManager.defaultManager;
var path = "$TARGET_FILE";
var error = null;

// Read file content
var data = fm.contentsAtPath(path);
var jsonString = $.NSString.alloc.initWithDataEncoding(data, $.NSUTF8StringEncoding).js;

var config = {};
try {
    config = JSON.parse(jsonString);
} catch(e) {
    config = {};
}

// Modify the target key
config["dev.containers.dockerPath"] = "podman";

// Write back to file
var updatedString = $.NSString.alloc.initWithString(JSON.stringify(config, null, 4));
updatedString.writeToFileAtomicallyEncodingError(path, true, $.NSUTF8StringEncoding, null);
EOF

echo "Successfully updated VS Code settings on macOS."