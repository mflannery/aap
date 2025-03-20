#!/bin/bash

# Check how full the / filesystem is and put this value into a
# JSON object in a variable.  If the filesystem usage is
# greater than 80%, log the usage and make an api call to EDA.


# Check if usage is greater than 80%, if so, log the usage and make an api call to EDA
while ( 1=1 )
do
    # Get the filesystem usage percentage
    USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
    if [ "$USAGE" -gt 80 ]; then
        # Use logger to write usage to system logs
        logger -p user.warning "High filesystem usage: $USAGE% of root filesystem is full"
        #Build the JSON string/object
        JSON_STRING=$(jq -n --arg usage "$USAGE" '$ARGS.named')
        # Make API call to EDA sending the JSON object - first example without token, second with token
#       curl -X POST -H "Content-Type: application/json" -d "$JSON_STRING" aap25.home.io:3001/endpoint
#       curl -X POST -H "Authorization:Bearer redhat" -H "Content-Type: application/json" -d "$JSON_STRING" aap25.home.io:3001/endpoint
        curl -X POST -H "Authorization:Bearer VMbe5JIf9#!Z%t" -H "Content-Type: application/json" -d "$JSON_STRING" --insecure https://aap25.home.io:443/eda-event-streams/api/eda/v1/external_event_stream/c41d74d7-2ffb-4a43-af75-41ab251abb2c/post/
done