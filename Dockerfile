FROM perl

RUN apt-get update && apt-get install -y recutils
RUN yes|cpan install List::Flatten

RUN mkdir /recs
WORKDIR /recs

