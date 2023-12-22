use 5.010_000;
use strict;
use utf8;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Glib qw(TRUE FALSE);
use Test::More tests => 3;

require_ok ('Clawsker');

my ($temp, $rc);

BEGIN {
    $temp = tempdir (CLEANUP => 1);
    $rc = catfile ($temp, 'menurc');
    open my $rcf, '>', $rc
        or die "opening $rc for writing: $!\n";
    print $rcf <<EORC
; (gtk_accel_path "<Actions>/Menu/Edit/One" "")
(gtk_accel_path "<Actions>/Menu/Edit/Two" "<Primary>t")
EORC
}

use Clawsker;

is ( -s $rc, 104, 'resource present' );

my %expected = (
    'Actions' => {
        '/Menu/Edit/One' => {
            'key' => '""', 'enabled' => FALSE, 'line' => 0,
        },
        '/Menu/Edit/Two' => {
            'key' => '"<Primary>t"', 'enabled' => TRUE, 'line' => 1,
        },
    },
);

is_deeply (
    Clawsker::load_menurc($rc),
    \%expected,
    'data loaded'
);

