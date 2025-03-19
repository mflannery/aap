#!/bin/bash

# Command to execute when a failed login is detected
ACTION="logger -p user.warning 'Failed login detected at $(date)'"
# Replace the above with your desired command, e.g., "systemctl restart some-service" or a custom script

# Monitor SSH logs for failed password attempts
journalctl -u sshd -f | while read -r line; do
    if echo "$line" | grep -iq "Failed password"; then
        echo "Failed login attempt detected: $line"
        # Execute the command
        eval "$ACTION"
    fi
done