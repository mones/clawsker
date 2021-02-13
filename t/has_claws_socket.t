use 5.010_000;
use strict;
use utf8;
use File::Temp qw(tempdir);
use File::Spec::Functions;
use Digest::MD5 qw(md5_hex);
use Glib qw(TRUE FALSE);
use IO::Socket::UNIX;
use Test::More tests => 3;

require_ok ('Clawsker');

my ($dirok, $dirko);

BEGIN {
    my $tempdir = tempdir (CLEANUP => 1);
    $dirok = catfile ($tempdir, 'ok');
    mkdir $dirok;
    $dirko = catfile ($tempdir, 'ko');
    mkdir $dirko;
    my $md5 = md5_hex ($ENV{HOME} . '/.claws-mail');
    my $path = catfile ($dirok, $md5);
    my $sock = IO::Socket::UNIX->new(
        Type => SOCK_STREAM(), Local => $path, Listen => 1
    );
}

use Clawsker;

is (
    Clawsker::has_claws_socket ($dirok), TRUE,
    'ok has it'
);

is (
    Clawsker::has_claws_socket ($dirko), FALSE,
    'ko does not'
);
