use 5.010_000;
use strict;
use utf8;
use Test::NeedsDisplay;
use Test::More tests => 3;
use Gtk3;

require_ok ('Clawsker');

use Clawsker;

Gtk3->init;

ok ( defined &Clawsker::get_screen_height, 'has function' );

my $height = Clawsker::get_screen_height();

ok ( $height > 0, "has $height pixels" );

