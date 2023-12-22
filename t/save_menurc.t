use 5.010_000;
use strict;
use utf8;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Glib qw(TRUE FALSE);
use Test::More tests => 3;

require_ok ('Clawsker');

my ($temp, %data, $rc);

BEGIN {
    $temp = tempdir (CLEANUP => 1);
    $rc = catfile ($temp, 'menurc');
    %data = (
        'Actions' => {
            '/Menu/Edit/One' => {
                'key' => '""', 'enabled' => FALSE, 'line' => 0,
            },
            '/Menu/Edit/Two' => {
                'key' => '"<Primary>t"', 'enabled' => TRUE, 'line' => 1,
            },
        },
    );
}

use Clawsker;

is ( -s $rc, undef, 'resource absent' );

Clawsker::save_menurc($rc, \%data);

is ( -s $rc, 104 + 107, 'resource created' );

