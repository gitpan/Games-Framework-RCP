package RCPTest;

use Test::More;

eval "use DBD::SQLite";
if ($@)
{
    plan skip_all => 'Install DBD::SQLite for the database tests.';
}

use Games::Framework::RCP::Setup qw(login);

use Sub::Exporter -setup => { exports => [ qw(get_schema) ] };

my $schema = login('dbi:SQLite:dbname=./rcp_test.db', undef, undef, {AutoCommit => 1});
unlink('./rcp_test.db');
$schema->deploy(); # Testing SQLite: no need to add_drop_tables.

sub get_schema
{
    return $schema;
}

1;