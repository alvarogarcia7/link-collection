FROM perl

RUN apt-get update && apt-get install -y recutils

RUN mkdir /recs
WORKDIR /recs

