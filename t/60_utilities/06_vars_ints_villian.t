#!perl -T

use Test::More;
use Games::Framework::RCP::Utilities::Vars_Ints;

BEGIN {
    eval "use Test::Exception";
    if ( $@ ) {
        plan skip_all => 'Install Test::Exception for these tests.';
    } else {
        plan tests => 14;
    }
}

my $dbh = Games::Framework::RCP::Database->instance
({
	user => $ENV{DB_TEST_USERNAME},
	pass => $ENV{DB_TEST_PASSWORD}
});

$dbh->begin_work();

my $name  = 'is_ref_cool_✓';
my $value = 1;

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::insert_integer_variable($name, "buubot" . $value) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'The value must be an integer.'
);

ok(
    Games::Framework::RCP::Utilities::Vars_Ints::insert_integer_variable($name, $value),
    'Insert a new integer variable.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::insert_integer_variable($name, $value) },
    'Games::Framework::RCP::Exceptions::Database::Non_Unique',
    'Cannot insert the same variable twice.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::update_integer_variable_value_by_name($name, "GummyBRAIN" . $value) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Cannot update a variable if it is not an integer.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::update_integer_variable_value_by_name($name . "GummyBRAIN", $value) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::invert_integer_variable_by_name($name . "jdv79") },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

ok(
    Games::Framework::RCP::Utilities::Vars_Ints::delete_integer_variable_by_name($name),
    'Delete a integer variable.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::delete_integer_variable_by_name($name) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot delete a variable that is gone.'
);

ok(
    Games::Framework::RCP::Utilities::Vars_Ints::insert_integer_variable($name, $value),
    'Reinsert the variable.'
);

my $id = Games::Framework::RCP::Utilities::Vars_Ints::select_id_by_integer_variable($name);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::update_integer_variable_value_by_id($id + 9000, $value) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::update_integer_variable_value_by_id($id, "nine thousand" . $value) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Cannot update a variable that is not an integer'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::invert_integer_variable_by_id($id + 9000) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

ok(
    Games::Framework::RCP::Utilities::Vars_Ints::delete_integer_variable_by_id($id),
    'Delete the variable by its ID.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Ints::delete_integer_variable_by_id($id) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot delete a variable that is not in the database.'
);


$dbh->rollback();
