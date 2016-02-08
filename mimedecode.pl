#!/usr/bin/perl
#
# Extract the mime parts of an email to seperate files.
#
# Usage:
#   mimedecode.pl <SOURCE_FILE> <TARGET_DIRECTORY>

use MIME::Parser;
my $parser = MIME::Parser->new();
$parser->output_dir($ARGV[1]);
$parser->output_to_core();
$parser->parse_open($ARGV[0]);
