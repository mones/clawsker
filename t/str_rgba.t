use 5.010_000;
use strict;
use utf8;
use Test::More tests => 6;

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

