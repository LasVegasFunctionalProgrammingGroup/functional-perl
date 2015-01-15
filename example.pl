#! /usr/bin/env perl

use strict;
use warnings;

use BetterList;
use Input;
use Output;
use Shared qw(compose and_then curry swap partially tap forever lift);

my $print = sub {
  my $prompt = $_[0];
  
  return compose(Output->ex, lift $prompt);
};
my $println = and_then(Output->ex, $print->("\n"));

my $getline = sub {
  my $prompt = $_[0];

  return and_then($print->($prompt), Input->ex);
};

my $program =
  and_then tap($print->("Args? ")),
  and_then tap(compose $println, sub { return join ', ', @_ }),
  and_then tap($print->("Hello! Please enter some text. I'll echo it back!")),
  and_then $getline->("\n> "),
  and_then tap($print->("You said: ")),
  $println;

$program->(@ARGV);
