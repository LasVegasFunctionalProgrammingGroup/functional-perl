#! /usr/bin/env perl

print "Hello, LVFPUG!\n";

########===========
#exit 0;

# sub println($arg) { } isn't a thing!
# arguments are passed in _
# to access them as an array, @_
# a specific element would be $_[idx], starting from 0
sub println {
  print $_[0] . "\n";
}

println "We meet again, LVFPUG.";

my $call_amount = 10000000;

# "my X" declares X as local to its scope.
# with out "my", variables are global by default.
# "use strict;" makes perl give an error when omitting
# declaration of a variable as global or local
sub tail_call {
  my $count = $_[0];
  if ($count == 0) {
    println "Done recursing!";
  } elsif ($count == $call_amount / 2) {
    println "Halfway there..";
  }
  tail_call($count - 1);
}

# if we want this presentation done tonight..
# don't uncomment this :)
#tail_call($call_amount);

# perl doesn't do tail-call optimization, but does
# do interesting things about stack space.. the above
# didn't nuke my stack, but did eat all of the computer's memory.

########===========
#exit 0;

sub lazy_println {
  my $fn = $_[0];

  println $fn->();
}

sub add_stuff {
  return 1 + 1;
}

println "\n  Function evaluation";
println \&add_stuff;
lazy_println \&add_stuff;

lazy_println sub { return "λ!"; };

#exit 0;

local $/ = "\n"; # this makes reading from stdin end at return instead of EOF (aka ctrl+d)

sub nextline {
  while(<STDIN>) { chomp $_; return $_; }
}

sub compose {
  my ($f, $g) = @_;

  return sub { $f->($g->(@_)) }
};

sub prompt {
  print "Enter a string: ";
  println nextline;
};

prompt;

$composed_prompt = compose sub { println $_[0] }, compose sub { nextline }, sub { print $_[0]; };

$composed_prompt->("[Composition] enter another line: ");

