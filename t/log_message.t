use 5.010_000;
use strict;
use utf8;
use Test::More tests => 6;
use Test::Output;
use Test::Exception;

require_ok ('Clawsker');

use Clawsker;

stdout_is {
  Clawsker::log_message('error') } '', 'no verbose';

Clawsker::parse_command_line(['--verbose']);

stdout_is {
  Clawsker::log_message('error') } "clawsker: error\n", 'verbose';

lives_ok {
  Clawsker::log_message('error', 'ouch') } 'invalid fatal';

stdout_is {
  Clawsker::log_message('error', 'ouch') } "clawsker: error\n", 'message';

dies_ok {
  Clawsker::log_message('error', 'die') } 'ok fatal';
