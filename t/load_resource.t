use 5.010_000;
use strict;
use utf8;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Test::More tests => 7;

require_ok ('Clawsker');

my ($temp, $rc1);

BEGIN {
    $temp = tempdir (CLEANUP => 1);
    $rc1 = catfile ($temp, 'ok.rc');
    open my $rcf, '>', $rc1
        or die "opening $rc1 for writing: $!\n";
    print $rcf <<EORC
[sect1]
key1=value 1
# some comment
key2=value 2

[sect2]
# another comment
# with two lines
key1=value 3

[sect3]
# empty

EORC
}

use Clawsker;

my ($data, $meta) = Clawsker::load_resource($rc1);
is ( ref $data, 'HASH', 'data is map' );
is ( ref $meta, 'HASH', 'meta is map' );
is ( keys %$data, 3, 'data has 2 keys' );
is ( keys %$meta, 3, 'meta has 2 keys' );
is_deeply (
  $data,
  { 'sect1' => {
    'key1' => 'value 1',
    'key2' => 'value 2',
    '_' => [ '# some comment' ]
  }, 'sect2' => {
    'key1' => 'value 3',
    '_' => [ '# another comment', '# with two lines' ]
  }, 'sect3' => {
    '_' => [ '# empty' ]
  }},
  'data ok'
);
is_deeply (
  $meta,
  { 'sect2' => {
    'key1' => 9, '#' => 6
  }, 'sect1' => {
  'key1' => 2, 'key2' => 4, '#' => 1
  }, 'sect3' => {
    '#' => 11
  }},
  'meta ok'
);
