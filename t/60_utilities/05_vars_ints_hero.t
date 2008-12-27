#!perl -T

use Test::More;
use Games::Framework::RCP::Utilities::Vars_Ints;
use utf8;

plan tests => 22;
my $dbh = Games::Framework::RCP::Database->instance
({
	user => $ENV{DB_TEST_USERNAME},
	pass => $ENV{DB_TEST_PASSWORD}
});

$dbh->begin_work();

my $name  = 'is_ref_cool_✓';
my $value = 1;

is( Games::Framework::RCP::Utilities::Vars_Ints::insert_integer_variable($name, $value), 1, "Verify inserting a integer variable can work.");

my $id = Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name);

is_deeply( Games::Framework::RCP::Utilities::Vars_Ints::select_integer_variable_value_by_id($id), $value, "Verify the same value we just put in.");

is( Games::Framework::RCP::Utilities::Vars_Ints::update_integer_variable_value_by_id($id, --$value), 1, "Verify updating integer variables can work.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_integer_variable_value_by_name($name), $value, "Confirm value updates.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name), $id, "Confirm the ID is still the same.");

is( Games::Framework::RCP::Utilities::Vars_Ints::update_integer_variable_value_by_name($name, ++$value), 1, "Verify updating integer variables can work.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_integer_variable_value_by_name($name), $value, "Confirm value updates.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name), $id, "Confirm the ID is still the same.");

is( Games::Framework::RCP::Utilities::Vars_Ints::invert_integer_variable_by_id($id), 1, "Verify inverting integer variables can work.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_integer_variable_value_by_name($name), $value * -1, "Confirm value updates.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name), $id, "Confirm the ID is still the same.");

is( Games::Framework::RCP::Utilities::Vars_Ints::invert_integer_variable_by_name($name), 1, "Verify inverting integer variables can work.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_integer_variable_value_by_name($name), $value, "Confirm value updates.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name), $id, "Confirm the ID is still the same.");

is( Games::Framework::RCP::Utilities::Vars_Ints::invert_all_integer_variables(), 1, "Verify updating integer variables can work.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_integer_variable_value_by_id($id), $value * -1, "Confirm value updates.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name), $id, "Confirm the ID is still the same.");

is( Games::Framework::RCP::Utilities::Vars_Ints::delete_integer_variable_by_id($id), 1, "Confirm we can remove by ID.");

is( Games::Framework::RCP::Utilities::Vars_Ints::insert_integer_variable($name, $value), 1, "Put the same variable in again.");
is( Games::Framework::RCP::Utilities::Vars_Ints::delete_integer_variable_by_name($name), 1, "Remove the variable by name: can't use ID due to it being used.");

is( Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name), undef, "Confirm the previous variable was removed.");
is( Games::Framework::RCP::Utilities::Vars_Ints::select_integer_variable_value_by_id($id), undef, "Confirm the previous variable was removed.");

$dbh->rollback();