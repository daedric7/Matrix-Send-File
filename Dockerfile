FROM alpine:latest
RUN apk add bash markdown curl jq file coreutils
COPY entrypoint.sh /
COPY matrix.sh /
RUN chmod +x /entrypoint.sh
RUN chmod +x /matrix.sh
ENTRYPOINT /entrypoint.sh
