use 5.010_000;
use strict;
use utf8;
use Glib qw(TRUE FALSE);
use Test::More tests => 8;

require_ok ('Clawsker');

use Clawsker;

ok (
    defined &Clawsker::version_greater_or_equal,
    'has the function'
);

ok (
    TRUE == Clawsker::version_greater_or_equal ('', ''),
    'empty is equal to empty reference version'
);

ok (
    FALSE == Clawsker::version_greater_or_equal ('1', ''),
    'everything is lower than empty referece version (show it all)'
);

ok (
    TRUE == Clawsker::version_greater_or_equal ('', '1'),
    'empty is greater than reference version 1 (show unversioned)'
);

ok (
    TRUE == Clawsker::version_greater_or_equal ('1', '1'),
    '1 is equal to reference version 1'
);

ok (
    TRUE == Clawsker::version_greater_or_equal ('2', '1'),
    '2 is greater than reference version 1'
);

ok (
    FALSE == Clawsker::version_greater_or_equal ('0.9.99', '1'),
    '0.9.99 is not greater than reference version 1'
);

