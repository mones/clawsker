
use 5.010_000;
use strict;
use utf8;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Test::More tests => 3;

require_ok ('Clawsker');

my ($temp, $history);

BEGIN {
    $temp = tempdir (CLEANUP => 1);
    $history = catfile ($temp, 'history_file');
    open my $hif, '>', $history
        or die "opening $history for writing: $!\n";
    print $hif <<HISTORY
 one
   two two

three three three

HISTORY
}

use Clawsker;

my $data = Clawsker::load_history($history);
is ( ref $data, '', 'scalar' );
is ( $data, "one\ntwo two\nthree three three", 'content' );
