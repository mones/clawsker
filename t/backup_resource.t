use 5.010_000;
use strict;
use utf8;
use Glib qw(TRUE FALSE);
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Test::More tests => 7;

require_ok ('Clawsker');

my ($temp, $rc, $rb);

BEGIN {
    $temp = tempdir (CLEANUP => 1);
    $rc = catfile ($temp, 'some.rc');
    $rb = catfile ($temp, 'some.rc.backup');
    open my $rcf, '>', $rc
        or die "opening $rc for writing: $!\n";
    print $rcf <<EORC
[section]
key1=value 1
# some comment
key2=value 2
EORC
}

use Clawsker;

is ( -s $rc, 51, 'resource present' );
is ( -s $rb, undef, 'backup absent' );

is ( Clawsker::backup_resource($rc), TRUE, 'success' );

is ( -s $rc, undef, 'resource absent' );
is ( -s $rb, 51, 'backup present' );

local %ENV;
$ENV{'DISPLAY'} = ''; # avoid error dialogs

is ( Clawsker::backup_resource('missingrc'), FALSE, 'failure' );

