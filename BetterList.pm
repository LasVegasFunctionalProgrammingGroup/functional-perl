package BetterList;

use Exporter 'import';

use strict;
use warnings;

sub new {
  my ($class, @args) = @_;
  return bless { data => \@args }, $class;
};

sub stringify {
  my ($self) = @_;
  return "BetterList=[@{[join ',', @{$self->{data}}]}]";
}

sub map {
  my ($self, $fn) = @_;

  my @new = ();
  foreach my $x (@{$self->{data}}) {
    my $val = $fn->($x);
    push @new, $val;
  }

  return BetterList->new(@new);
}

sub foldLeft {
  my ($self, $start, $fn) = @_;

  my @new = ();
  my $accum = $start;
  foreach my $x (@{$self->{data}}) {
    $accum = $fn->($accum, $x);
  }

  return $accum;
}

1;
