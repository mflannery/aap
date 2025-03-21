#!/bin/bash

# Command to execute when a failed login is detected
ACTION="logger -p user.warning 'Failed login detected at $(date)'"
# Replace the above with your desired command, e.g., "systemctl restart some-service" or a custom script

# Monitor SSH logs for failed password attempts
journalctl -u sshd -f | while read -r line; do
    if echo "$line" | grep -iq "Failed password"; then
        echo "Failed login attempt detected: $line"
        # Execute the command
        IP=$(echo "$line" | sed 's/.*from \([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/')
        JSON_STRING=$(jq -n --arg login "failed" '$ARGS.named' --arg ipaddress "$IP" 'ARGS.named')
        curl -X POST -H "Authorization:Bearer VMbe5JIf9#!Z%t" -H "Content-Type: application/json" -d "$JSON_STRING" --insecure https://aap25.home.io:443/eda-event-streams/api/eda/v1/external_event_stream/c41d74d7-2ffb-4a43-af75-41ab251abb2c/post/
    fi
done