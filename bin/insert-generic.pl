#!/usr/bin/env perl

use List::Flatten;

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

my $title = read_one_line("Input title (1 line, mandatory)\n");
$title =~ s/"/\\"/g;
my $link =  read_one_line("Input link (1 line, optional)\n");

## If link in Markdown format
if ($title =~ m/\[.*\]\(.*\)/) {
  ($title, $link) = $title =~ m/\[(.*)\]\((.*)\)/;
}

my $body = join('\n', read_until_ctrl_d("Input body, as is. Ctrl+D to finish inputting\n"));
$body =~ s/"/\\"/g;

##Fake
#my $title = "title";
#my $link =  "link"; 
#my $body = "body";

## Read tags (one or more; lowercase, snake-case)
my @tags = read_until_ctrl_d("Input one tag per line. Ctrl+D to finish inputting\n"); 
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
#my @tags2 = @tags
#    .map { $_ }
#    .map { s/Tags://i }
#    .map { my $tag=$_; chomp $tag; $tag =~ s/^\s*//; $tag}
#    .map { my $tag=$_; $tag=lc($tag); $tag =~ s/(\w) /$1-/g; $tag} 
#    .map { my @tags=split(/,/, $_); @tags }
#    .flat;

#print (map {"$_\n"} @tags2);
my $tagsCommaSeparated =  join(', ', @tags2);

## Prepare command

# https://lists.gnu.org/archive/html/bug-recutils/2019-08/msg00001.html
# Yes, this is a known bug in 1.8.  It happens when /tmp is mounted in a separated filesystem.
# You can workaround the problem defining the TMPDIR environment variable.  Try, for example, $ TMPDIR=. recset ...

my $command="TMPDIR=. recins -t Link ";
$command.="-f Title -v \"$title\" ";
$command.="-f Link -v \"$link\" ";
$command.="-f Body -v \"$body\" ";
$command.="-f Category -v \"$category\" ";
$command.="-f Tags -v \"$tagsCommaSeparated\"";
$command.=' ';
$command.='data/links.rec';

## Dry run
print "$command\n";

`$command`
