#!/usr/bin/env perl

use List::Flatten;
require HTTP::Request;
require LWP::UserAgent;
use JSON::XS;
use Data::Dumper;

use strict;
use warnings;

#my $title = shift or die "Usage: $0 'title'\n";

sub read_until_ctrl_d {
  my ($prompt) = @_;
  print $prompt;
  my @result;
  for(;;) {
      my $input = <STDIN>;
      last if not defined $input;
      chomp $input;
      push @result, $input;
  };

  return @result; 
}

sub remove_whitespace {
  my ($text) = @_;
  chomp $text;
  $text =~ s/^\s*//;
  return $text;
}

sub read_one_line {
  my ($prompt) = @_;
  print $prompt;
  my $rawResult = <STDIN>;
  my $result = remove_whitespace($rawResult);
  return $result;
}

my $category=$ARGV[0];
my $hackernews_id=$ARGV[1];


my $request = HTTP::Request->new(GET => 'https://hacker-news.firebaseio.com/v0/item/' . $hackernews_id . '.json');
my $ua = LWP::UserAgent->new;
my $content = $ua->request($request)->content();
# Fake contents
# my $content = '{"by":"vanusa","descendants":58,"id":27186675,"kids":[27187653,27187539,27187568,27186985,27187051,27187507,27186969,27187038,27187320],"score":218,"time":1621276965,"title":"Why Is the Gaza Strip Blurry on Google Maps?","type":"story","url":"https://www.bbc.com/news/57102499"}';
my $response = decode_json($content);
print Data::Dumper->Dump([$response], [qw(response)]);

my $date=localtime(${$response}{time});

# my $title = read_one_line("Input title (1 line, mandatory)\n");
my $title = ${$response}{title};
$title =~ s/"/\\"/g;
my $link =  'https://news.ycombinator.com/item?id='. $hackernews_id;

my $body = join('\n', read_until_ctrl_d("Input body, as is. Ctrl+D to finish inputting\n"));
$body =~ s/"/\\"/g;

##Fake
#my $title = "title";
#my $link =  "link"; 
#my $body = "body";

## Read tags (one or more; lowercase, snake-case)
my @tags = read_until_ctrl_d("Input one tag per line. Ctrl+D to finish inputting\n"); 
push @tags, "imported";
push @tags, "hacker-news";
my @tags2 = 
  map {my $tag=$_; chomp $tag; $tag =~ s/^\s*//; $tag} # trim both sides
  flat
  map { my @tags=split(/,/, $_); @tags } #split by comma
  map {my $tag=$_; $tag =~ s/(\w) /$1-/g; $tag} # snake-case
  map {my $tag=$_; $tag=lc($tag); $tag} # lowercase
  map {my $tag=$_; chomp $tag; $tag =~ s/^\s*//; $tag =~ s/\s*$//; $tag} # trim both sides
  map { s/Tags://i; $_ } 
  map { $_ } 
  @tags;

#print (map {"$_\n"} @tags2);
my $tagsCommaSeparated =  join(', ', @tags2);

## Prepare command
my $command="recins -t Link ";
$command.="-f Date -v \"$date\" ";
$command.="-f Title -v \"$title\" ";
$command.="-f Link -v \"$link\" ";
$command.="-f Body -v \"$body\" ";
$command.="-f Category -v \"$category\" ";
$command.="-f Tags -v \"$tagsCommaSeparated\" ";
$command.=' ';
$command.='data/links.rec';

## Dry run
print "$command\n";

`$command`
`git add .`
`git commit -m "Save progress" --date="$date"`
