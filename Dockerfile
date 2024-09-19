FROM alpine:latest
RUN apk add bash markdown curl jq file
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh
