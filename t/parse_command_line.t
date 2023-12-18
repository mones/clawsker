use 5.010_000;
use strict;
use utf8;
use Test::More tests => 17;
use Test::Exception;
use File::Spec::Functions;

my ($clawsrc, $accountrc, $menurc);

BEGIN {
    $clawsrc = catfile ($ENV{'XDG_RUNTIME_DIR'}, 'clawsrc');
    $accountrc = catfile ($ENV{'XDG_RUNTIME_DIR'}, 'accountrc');
    $menurc = catfile ($ENV{'XDG_RUNTIME_DIR'}, 'menurc');
}

local %ENV;
$ENV{'DISPLAY'} = ''; # avoid error dialogs

require_ok ('Clawsker');

use Clawsker;

ok ( defined &Clawsker::parse_command_line, 'has function' );

lives_ok { Clawsker::parse_command_line(['--help']) } '--help';

lives_ok { Clawsker::parse_command_line(['--version']) } '--version';

lives_ok { Clawsker::parse_command_line(['--verbose']) } '--verbose';

lives_ok { Clawsker::parse_command_line(['--read-only']) } '--read-only';

lives_ok { Clawsker::parse_command_line(['--small-screen']) } '--small-screen';

lives_ok { Clawsker::parse_command_line(['--ignore-versions']) } '--ignore-versions';

lives_ok { Clawsker::parse_command_line(['--hide-disabled-keys']) } '--hide-disabled-keys';

dies_ok { Clawsker::parse_command_line(['--use-claws-version']) } '--use-claws-version';

lives_ok { Clawsker::parse_command_line(['--use-claws-version', '1.0.0']) } '--use-claws-version ok';

dies_ok { Clawsker::parse_command_line(['--use-claws-version', 'invalid']) } '--use-claws-version ko';

dies_ok { Clawsker::parse_command_line(['--alternate-config-dir']) } '--alternate-config-dir';

dies_ok { Clawsker::parse_command_line(['--alternate-config-dir', '/notexisting']) } '--alternate-config-dir';

lives_ok { Clawsker::parse_command_line(['--alternate-config-dir', '.']) } '--alternate-config-dir ok';

dies_ok { Clawsker::parse_command_line(['--clawsrc']) } '--clawsrc';

dies_ok { Clawsker::parse_command_line(['--invalid']) } 'invalid option';

