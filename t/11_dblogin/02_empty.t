#!perl

use Test::More;
use lib 't/lib/';
use RCPTest qw(get_schema);

my $schema = get_schema();

plan tests => scalar $schema->sources + 1;

ok( defined $schema, 'Confirm the schema is defined.');

is($schema->resultset($_)->count, 0, "Confirm $_ Table starts off empty.") for $schema->sources;