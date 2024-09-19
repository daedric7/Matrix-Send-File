#!/bin/bash

escape() {
        local multil=
        [ $(echo "$1" | wc -l) -gt 1 ] && multil="-s"
        jq $multil -R . <<<"$1"
}

echo "File: $INPUT_FILE"
echo "Server: $INPUT_SERVER"
echo "Token: $INPUT_ACCESS_TOKEN"
echo "Room: $INPUT_ROOM_ID"

content_type=$(file --brief --mime-type "$INPUT_FILE")

response=$(curl -s --oauth2-bearer "$INPUT_ACCESS_TOKEN" -H "User-Agent: github/send-file" -XPOST --data-binary "$INPUT_FILE" -H "Content-Type: $content_type" "$INPUT_SERVER/_matrix/media/r0/upload?filename=$INPUT_FILE" )

echo $response

uri=$(jq -r .content_uri <<<"$response")

filename=$(basename "$INPUT_FILE")

data="{\"body\":$(escape "$filename"), \"msgtype\":\"m.file\", \"filename\":$(escape "$filename"), \"url\":\"$uri\"}"

txn=`date +%s%N`

response=$( curl -s --oauth2-bearer "$INPUT_ACCESS_TOKEN" -H "User-Agent: github/send-file" -XPUT -H "Content-Type: application/json" --data "$data" "$INPUT_SERVER"/_matrix/client/v3/rooms/$INPUT_ROOM_ID/send/m.room.message/$txn"" )

echo $response
