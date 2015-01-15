#! /usr/bin/env perl

package Shared;

use Exporter 'import';
@EXPORT_OK = qw(compose and_then partially println curry swap tap forever lift);

use strict;
use warnings;

sub println {
  print @_;
  print "\n";
}

sub compose {
  my ($f, $g) = @_;
  return sub { return $f->($g->(@_)) };
};

sub and_then {
  my ($f, $g) = @_;
  return compose($g, $f);
};

sub tap {
  my ($f) = @_;

  return sub {
    my @args = @_;
    $f->(@args);
    return @args;
  };
}

sub lift {
  my @vals = @_;
  return sub { return @vals; }
}

sub forever {
  $_[0]->(); forever(@_);
}

# currying isn't really possible in general!
# there's no way to know the number of arguments
# a function expects to get. so one-arg partial
# application seems okay...
sub partially {
  my ($f, $arg) = @_;

  return sub {
    $f->(($arg), @_);
  };
};

sub curry {
  my $f = $_[0];

  return sub {
    return partially($f, $_[0]);
  }
}

sub swap {
  my $f = $_[0];

  return sub {
    push @_, shift @_;
    return $f->(@_);
  };
};

1;
