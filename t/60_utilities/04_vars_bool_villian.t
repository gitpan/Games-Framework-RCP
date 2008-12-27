#!perl -T

use Test::More;
use Games::Framework::RCP::Utilities::Vars_Bool;

BEGIN {
    eval "use Test::Exception";
    if ( $@ ) {
        plan skip_all => 'Install Test::Exception for these tests.';
    } else {
        plan tests => 11;
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

ok(
    Games::Framework::RCP::Utilities::Vars_Bool::insert_boolean_variable($name, $value),
    'Insert a new boolean variable.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Bool::insert_boolean_variable($name, $value) },
    'Games::Framework::RCP::Exceptions::Database::Non_Unique',
    'Cannot insert the same variable twice.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Bool::update_boolean_variable_value_by_name($name . "GummyBRAIN", $value) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Bool::invert_boolean_variable_by_name($name . "jdv79") },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

ok(
    Games::Framework::RCP::Utilities::Vars_Bool::delete_boolean_variable_by_name($name),
    'Delete a boolean variable.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Bool::delete_boolean_variable_by_name($name) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot delete a variable that is gone.'
);

ok(
    Games::Framework::RCP::Utilities::Vars_Bool::insert_boolean_variable($name, $value),
    'Reinsert the variable.'
);

my $id = Games::Framework::RCP::Utilities::Vars_Bool::select_id_by_boolean_variable($name);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Bool::update_boolean_variable_value_by_id($id + 9000, $value) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Bool::invert_boolean_variable_by_id($id + 9000) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot update a variable that does not exist.'
);

ok(
    Games::Framework::RCP::Utilities::Vars_Bool::delete_boolean_variable_by_id($id),
    'Delete the variable by its ID.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Vars_Bool::delete_boolean_variable_by_id($id) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Cannot delete a variable that is not in the database.'
);


$dbh->rollback();
