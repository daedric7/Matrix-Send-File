#!/bin/bash
echo "File: $INPUT_FILE"
echo "Server: $INPUT_SERVER"
echo "Token: $INPUT_ACCESS_TOKEN"
echo "Room: $INPUT_ROOM_ID"
echo "Message: $INPUT_MESSAGE"


/matrix.sh --token=$INPUT_ACCESS_TOKEN --homeserver=$INPUT_SERVER --room=$INPUT_ROOM_ID $INPUT_MESSAGE
/matrix.sh --token=$INPUT_ACCESS_TOKEN --homeserver=$INPUT_SERVER --room=$INPUT_ROOM_ID --file=$INPUT_FILE
