use 5.010_000;
use strict;
use utf8;
use File::Temp qw(tempdir);
use Test::More tests => 4;

require_ok ('Clawsker');

my ($tempdir1, $claws1, $tempdir2, $claws2);

BEGIN {
    $tempdir1 = tempdir ();
    $tempdir2 = "$tempdir1/with space";
    $claws1 = "$tempdir1/claws-mail";
    $claws2 = "$tempdir2/claws-mail";
    qx {
        echo '#!/bin/sh' > $claws1
        echo 'test "\$1" = '-v' && echo "Claws Mail version 3.2.1"' >> $claws1
        chmod +x $claws1
        mkdir "$tempdir2"
        cp -p "$claws1" "$claws2"
    };
};

END {
    qx {
        rm -rf $tempdir1
    };
};

local %ENV;
$ENV{'PATH'} = $tempdir1;

use Clawsker;

ok (
    defined &Clawsker::get_claws_version,
    'has function'
);

ok (
    '3.2.1.0' eq Clawsker::get_claws_version(),
    'version ok 1'
);

$ENV{'PATH'} = $tempdir2;

ok (
    '3.2.1.0' eq Clawsker::get_claws_version(),
    'version ok 2'
);

