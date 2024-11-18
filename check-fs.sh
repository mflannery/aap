#!/bin/bash

# Check how full the / filesystem is and put this value into a
# JSON object in a variable.  If the filesystem usage is
# greater than 80%, log the usage and make an api call to EDA.

# Get the filesystem usage percentage
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

#Build the JSON string/object
JSON_STRING=$(jq -n --arg usage "$USAGE" '$ARGS.named')

# Check if usage is greater than 80%, if so, log the usage and make an api call to EDA
if [ "$USAGE" -gt 80 ]; then
    # Use logger to write to system logs
    logger -p user.warning "High filesystem usage: $USAGE% of root filesystem is full"
    # Make API call to EDA sending the JSON object 
    curl -X POST -H "Content-Type: application/json" -d "$JSON_STRING" aap25.home.io:3001/endpoint
fi
