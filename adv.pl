#! /usr/bin/env perl

use strict;
use warnings;
use Shared qw(compose partially println curry swap);
use Option qw(Some None);

sub add {
  return $_[0] + $_[1];
}

println "Curried, unapplied: ", curry(\&add);

println "Curried: ", curry(\&add)->(1)->(2);

println "Partially applied: ", partially(\&add, 1)->(2);


use BetterList;

my $list = BetterList->new(1, 2, 3, 4, 5);
#println $list->stringify;

sub concat {
  return $_[0] . $_[1];
}

#println concat "1", "2";
#println ((swap \&concat)->("1", "2"));

sub addone {
  return $_[0] + 1;
};

#println "each +1: ", $list->map(\&addone)->stringify;
#println "each +2: ", $list->map(sub { return $_[0] + 2; })->stringify;
#println "Sum: ", $list->foldLeft(0, sub { return $_[0] + $_[1] });

my $maybe = Option->new(1);
#println $maybe->stringify;
#println Some(1)->map(sub { return $_[0] + 1 })->stringify;
#println None()->map(sub { return $_[0] + 1 })->stringify;

my $genericMappyThing = compose(
  sub { return $_[0]->stringify; },
  sub { return $_[0]->map(sub { return $_[0] * 3 }) }
);

#println $genericMappyThing->(BetterList->new(1, 2, 3, 5, 7, 11));
#println $genericMappyThing->(Some(1));
