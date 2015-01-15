package Input;

use Exporter 'import';

use strict;
use warnings;

sub ex {
  sub { while(<STDIN>) { chomp $_; return $_; } }
};

1;
