use strict;
use warnings;

my $title = shift or die "Usage: $0 'title'\n";

my @tags;
print "Input one tag per line. Ctrl+D to finish inputting\n";
for(;;) {
    my $input = <STDIN>;
    last if not defined $input;
    chomp $input;
    push @tags, $input;
};

my @tagsAsFields = map {"-f Tag -v \"$_\""} @tags;

my $command="recins -t Link ";
$command.="-f Title -v \"$title\" ";
$command.=join(' ', @tagsAsFields);
$command.=' data/links.rec';

#print "$command\n";

`$command`
