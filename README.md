# Matrix Message github action

This is a simple github action to send files to matrix servers.

## Usage

Sending messages requires generating of an access token, which can be done with
`curl`, and is detailed [here](https://matrix.org/docs/guides/client-server-api/).

The Room ID does not refer to the room's name, but its unique ID. In Element, this
can be found by navigating to 'Room Settings' -> 'Advanced'.


```workflow
name: Send a hello world to matrix every 5 minutes
on:
  workflow_dispatch:
    
jobs:
  matrix-file-upload:
   runs-on: ubuntu-latest
   steps:
     - name: send message
       uses: daedric7/Matrix-Send-File@Marketplace
       with:
         room_id: ${{ secrets.MATRIX_ROOM_ID }}
         access_token: ${{ secrets.MATRIX_ACCESS_TOKEN }}
         file: /upload/this/file.txt
```


## Credits

This project was primarily created by Martin Pugh (pugh@s3kr.it). This version is a very slight change that might be
contributed back soon.

I just changed the one from olabiniV2/Matrix-Message further.
