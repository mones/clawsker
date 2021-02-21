use 5.010_000;
use strict;
use utf8;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Test::More tests => 4;

require_ok ('Clawsker');

my ($temp, $rc1, $data1, $meta1);

BEGIN {
    $temp = tempdir (CLEANUP => 1);
    $rc1 = catfile ($temp, 'ok.rc');
    $data1 = { 'sect1' => {
        'key1' => 'value 1',
        'key2' => 'value 2',
        '_' => [ '# some comment' ]
      }, 'sect2' => {
        'key1' => 'value 3',
        '_' => [ '# another comment', '# with two lines' ]
      }, 'sect3' => {
        '_' => [ '# empty' ]
      }
    };
    $meta1 = { 'sect2' => {
        'key1' => 9, '#' => 6
      }, 'sect1' => {
        'key1' => 2, 'key2' => 4, '#' => 1
      }, 'sect3' => {
        '#' => 11
      }
    };
}

use Clawsker;

ok ( ! -e $rc1, 'no file yet' );

Clawsker::save_resource($rc1, $data1, $meta1);

ok ( -s $rc1, 'file has data' );

open my $fh, '<', $rc1
    or die "opening $rc1 for reading: $!\n";
chomp(my @lines = <$fh>);
close $fh;

is_deeply (
  \@lines,
  [ '[sect1]',
    '# some comment',
    'key1=value 1',
    'key2=value 2',
    '',
    '[sect2]',
    '# another comment',
    '# with two lines',
    'key1=value 3',
    '',
    '[sect3]',
    '# empty',
    ''
  ],
  'data ok'
);
