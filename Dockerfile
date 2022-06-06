FROM perl

RUN apt-get update && apt-get install -y recutils
RUN yes|cpan install List::Flatten HTTP::Request LWP::UserAgent LWP::Protocol::https JSON::Parse JSON::XS

RUN git config --global user.email "alvarogarcia7@users.noreply.github.com"
RUN git config --global user.name "Alvaro Garcia"

RUN mkdir /recs
WORKDIR /recs

