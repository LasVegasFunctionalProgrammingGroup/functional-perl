package Output;

use Exporter 'import';

sub ex {
  return sub { print $_[0]; };
};

1;
