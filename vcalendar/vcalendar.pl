#!/usr/bin/env perl

# vcalendar.pl - create vcalendar files
# 2009-03-05 Peter Bonivart

# dtstart, dtend, summary, valarm

use strict;
use warnings;

my $debug = 0;
my $line;
my ($dtstart,$dtend,$summary,$valarm);

print "BEGIN:VCALENDAR\n";
print "VERSION:1.0\n";
print "PRODID:vcalendar.pl\n";

while ($line = <STDIN>) {
  chomp($line);
  my ($dtstart,$dtend,$summary,$valarm) = ($line =~ /^(.*)\|(.*)\|(.*)\|(.*)$/);
  print "$line ($dtstart:$dtend:$summary:$valarm)\n" if $debug;
  print "BEGIN:VEVENT\n";
  print "SUMMARY;CHARSET=ISO-8859-1:$summary\n";
  print "DTSTART;VALUE=DATE:$dtstart\n";
  print "DTEND:$dtend\n" if $dtend;
  print "BEGIN:VALARM\nTRIGGER:-P" . $valarm . "M\nACTION:DISPLAY\nDESCRIPTION:REMINDER\nEND:VALARM\n" if $valarm;
  print "END:VEVENT\n";
}

print "END:VCALENDAR\n";
