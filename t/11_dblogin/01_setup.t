#!perl

use Test::More;
use Games::Framework::RCP::Setup qw(load_defaults load_custom);
use lib 't/lib/';
use RCPTest qw(get_schema);

plan tests => 2;

my $schema = get_schema();

ok( defined $schema, 'Confirm the schema is defined.');

is( load_defaults(), 'Defaults loaded.', 'Confirm the defaults load.');

my $custom =
{
    VarsBool => 
    [
        {name => 'is_ref_cool', value => 1},
        {name => 'is_windows_sucky', value => 1},
    ],
    Character =>
    [
        {name => 'Linus Torvald', is_male => 1, is_good => 1, is_lawful => 1},
    ]
};

#TODO
#{
#    is (load_custom($custom), 'Customs loaded.', 'Confirm customized data can be sent.');
#}