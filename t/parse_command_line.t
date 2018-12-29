use 5.010_000;
use strict;
use utf8;
use Test::More tests => 10;
use Test::Exception;
use File::Spec::Functions;

my ($clawsrc, $accountrc, $menurc);

BEGIN {
    $clawsrc = catfile ($ENV{'XDG_RUNTIME_DIR'}, 'clawsrc');
    $accountrc = catfile ($ENV{'XDG_RUNTIME_DIR'}, 'accountrc');
    $menurc = catfile ($ENV{'XDG_RUNTIME_DIR'}, 'menurc');
};

local %ENV;
$ENV{'DISPLAY'} = ''; # avoid error dialogs

require_ok ('Clawsker');

use Clawsker;

ok ( defined &Clawsker::parse_command_line, 'has function' );

dies_ok { Clawsker::parse_command_line(['--invalid']) } 'invalid option';

dies_ok { Clawsker::parse_command_line(['--alternate-config-dir']) } '--alternate-config-dir';

dies_ok { Clawsker::parse_command_line(['--alternate-config-dir', '/notexisting']) } '--alternate-config-dir';

lives_ok { Clawsker::parse_command_line(['--alternate-config-dir', '.']) } '--alternate-config-dir ok';

lives_ok { Clawsker::parse_command_line(['--verbose']) } '--verbose';

dies_ok { Clawsker::parse_command_line(['--clawsrc']) } '--clawsrc';

lives_ok { Clawsker::parse_command_line(['--help']) } '--help';

lives_ok { Clawsker::parse_command_line(['--version']) } '--version';

