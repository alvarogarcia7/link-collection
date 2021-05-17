FROM perl

RUN apt-get update && apt-get install -y recutils
RUN yes|cpan install List::Flatten HTTP::Request LWP::UserAgent
RUN yes|cpan install LWP::Protocol::https
RUN yes|cpan install JSON::Parse
RUN yes|cpan install JSON::XS

RUN mkdir /recs
WORKDIR /recs

