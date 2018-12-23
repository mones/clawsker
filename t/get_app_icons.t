use 5.010_000;
use strict;
use utf8;
use Test::More tests => 4;

require_ok ('Clawsker');

use Clawsker;

ok ( defined &Clawsker::get_app_icons, 'has function' );

my $icons = Clawsker::get_app_icons;

ok ( 'ARRAY' eq ref ($icons), 'returns an array ref' );

ok ( 3 == @$icons, 'contains 3 elements' );

