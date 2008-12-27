#!perl -T

use Test::More;
use Games::Framework::RCP::Database;

plan tests => 5;
my $dbh = Games::Framework::RCP::Database->instance
({
	user => $ENV{DB_TEST_USERNAME},
	pass => $ENV{DB_TEST_PASSWORD}
});

ok (defined $dbh, "DB Handler defined!");

is( Games::Framework::RCP::Database->get_db_system, "Pg", "confirming DB system.");
is( Games::Framework::RCP::Database->get_db_name, "rcp", "confirming DB name.");
is( Games::Framework::RCP::Database->get_host, "localhost", "confirming host.");
is( Games::Framework::RCP::Database->get_port, "5432", "confirming port.");
