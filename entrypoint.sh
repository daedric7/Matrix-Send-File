#!/bin/sh

escape() {
        local multil=
        [ $(echo "$1" | wc -l) -gt 1 ] && multil="-s"
        jq $multil -R . <<<"$1"
}

echo "File: $FILE"

content_type=$(file --brief --mime-type "$FILE")

response=$(curl -s -H "$AUTHORIZATION" -H "User-Agent: github/send-file" -XPOST --data-binary "$FILE" -H "Content-Type: $content_type" "$INPUT_SERVER/_matrix/media/r0/upload?filename=$FILE" )

uri=$(jq -r .content_uri <<<"$response")

data="{\"body\":$(escape "$filename"), \"msgtype\":\"m.file\", \"filename\":$(escape "$filename"), \"url\":\"$uri\"}"

txn=`date +%s%N`

response=$( _curl -XPUT -H "Content-Type: application/json" --data "$data" "$INPUT_SERVER"/_matrix/client/v3/rooms/$INPUT_ROOM_ID/send/m.room.message/$txn"" )
