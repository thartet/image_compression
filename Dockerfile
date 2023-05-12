FROM ubuntu:22.04

RUN apt update && apt install -y pngquant imagemagick
COPY compress.sh /usr/bin/compress.sh
RUN chmod 777 /usr/bin/compress.sh