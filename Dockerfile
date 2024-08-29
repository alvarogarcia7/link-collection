FROM debian:stable-slim

RUN apt-get update && apt-get install -y recutils && apt-get clean && rm -rf /var/cache/apt/archives /var/lib/apt/lists/*

RUN mkdir /recs
WORKDIR /recs

