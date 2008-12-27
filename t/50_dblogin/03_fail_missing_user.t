#!perl -T

use Test::More;
use Games::Framework::RCP::Database;

BEGIN {
    eval "use Test::Exception";
    if ( $@ ) {
        plan skip_all => 'Install Test::Exception for this test.';
    } else {
        plan tests => 1;
    }
}

throws_ok(
    sub { Games::Framework::RCP::Database->instance ({ pass => $ENV{DB_TEST_PASSWORD} }) },
    'Games::Framework::RCP::Exceptions::Database::Missing_Credentials',
    'No user name.'
);