use 5.010_000;
use strict;
use utf8;
use Test::More tests => 10;

require_ok ('Clawsker');

use Clawsker;

ok ( defined &Clawsker::get_toolkit_versions, 'has function' );

my $versions = Clawsker::get_toolkit_versions;

is ( ref $versions, 'HASH', 'returns a hash ref' );

is ( scalar keys %$versions, 6, 'with 6 elements' );

my $regex = qr{^\d+\.\d+(\.\d+)?$};

like ( $versions->{'glib'}, $regex, 'has glib version' );
like ( $versions->{'glib-r'}, $regex, 'has glib-r version' );
like ( $versions->{'glib-b'}, $regex, 'has glib-b version' );

like ( $versions->{'gtk'}, $regex, 'has gtk version' );
like ( $versions->{'gtk-r'}, $regex, 'has gtk-r version' );
like ( $versions->{'gtk-b'}, $regex, 'has gtk-b version' );
