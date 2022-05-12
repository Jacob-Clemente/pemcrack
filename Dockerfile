# Build Stage
FROM --platform=linux/amd64 ubuntu:20.04 as builder

## Install build dependencies.
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y cmake libssl-dev

## Add source code to the build stage.
ADD . /pemcrack
WORKDIR /pemcrack

## TODO: ADD YOUR BUILD INSTRUCTIONS HERE.
RUN gcc pemcrack.c -o pemcrack -lssl -lcrypto

#Package Stage
FROM --platform=linux/amd64 ubuntu:20.04

## TODO: Change <Path in Builder Stage>
COPY --from=builder /pemcrack/pemcrack /
COPY --from=builder /lib/x86_64-linux-gnu/libcrypto.so.1.1 /lib/x86_64-linux-gnu/libcrypto.so.1.1

