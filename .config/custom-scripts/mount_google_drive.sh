#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mount Google Drive
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖

# Documentation:
# @raycast.description Use rclone to mount Google Drive
# @raycast.author rock_productivity
# @raycast.authorURL https://raycast.com/rock_productivity

echo "Mount Google Drive"

#!/bin/bash
/usr/local/bin/rclone mount gdrive: ~/GoogleDrive --allow-non-empty --daemon 