package Option;

use Exporter 'import';
@EXPORT_OK = qw(None Some Option);

use strict;
use warnings;

sub None {
  return Option->new;
};

sub Some {
  return Option->new(@_);
};

sub new {
  my ($class, $arg) = @_;
  if (defined $arg) {
    return bless { value => $arg }, $class;
  } else {
    return bless { value => undef }, $class;
  }
};

sub some {
  return defined $_[0]->{value};
}

sub eql {
  my ($self, $that) = @_;
  return $that->{value} == $self->{value};
}

sub stringify {
  my ($self) = @_;
  return $self->map(sub { return "Some($_[0])"; })->getOrElse("None");
}

sub map {
  my ($self, $fn) = @_;

  if ($self->some) {
    return Option->new($fn->($self->{value}));
  } else {
    return $self;
  }
}

sub fold {
  my ($self, $a, $b) = @_;

  if (not $self->some) {
    return Option->new($a->());
  } else {
    return Option->new($b->($self->{value}));
  }
}

sub getOrElse {
  my ($self, $alt) = @_;

  if ($self->some) {
    return $self->{value};
  } else {
    return $alt;
  }
}

1;
