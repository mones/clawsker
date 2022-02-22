use 5.010_000;
use strict;
use utf8;
use Gtk3;
use Test::More tests => 12;

require_ok ('Clawsker');

use Clawsker;

ok (
    defined &Clawsker::gdk_rgba_from_str,
    'has gdk_rgba_from_str function'
);

ok (
    defined &Clawsker::str_from_gdk_rgba,
    'has str_from_gdk_rgba function'
);


ok (
    '#123456' eq Clawsker::str_from_gdk_rgba(Clawsker::gdk_rgba_from_str('#123456')),
    'complementarity'
);

ok (
    '#000000' eq Clawsker::str_from_gdk_rgba(Clawsker::gdk_rgba_from_str('#000000')),
    'complementarity black'
);

ok (
    '#ffffff' eq Clawsker::str_from_gdk_rgba(Clawsker::gdk_rgba_from_str('#ffffff')),
    'complementarity white'
);

my @colors = (
    [Gtk3::Gdk::RGBA->new (1.0, 1.0, 1.0, 1.0), '#ffffff'],
    [Gtk3::Gdk::RGBA->new (1.0, 1.0, 1.0, 0.5), '#ffffff'],
    [Gtk3::Gdk::RGBA->new (0.505, 0.505, 0.505, 1.0), '#808080'],
    [Gtk3::Gdk::RGBA->new (0.505, 0.505, 0.505, 0.5), '#808080'],
    [Gtk3::Gdk::RGBA->new (0.0, 0.0, 0.0, 1.0), '#000000'],
    [Gtk3::Gdk::RGBA->new (0.0, 0.0, 0.0, 0.5), '#000000'],
);

for my $color (@colors) {
    is (
        Clawsker::str_from_gdk_rgba($color->[0]),
        $color->[1],
        join(' ', 'color', $color->[1])
    )
}
