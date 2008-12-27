#!perl -T

use Test::More;
use Games::Framework::RCP::Data::Classes;


BEGIN {
    eval "use Test::Exception";
    if ( $@ ) {
        plan skip_all => 'Install Test::Exception for these tests.';
    } else {
        plan tests => 44;
    }
}

my $dbh = Games::Framework::RCP::Database->instance
({
	user => $ENV{DB_TEST_USERNAME},
	pass => $ENV{DB_TEST_PASSWORD}
});

$dbh->begin_work();

my $name  = '∅∆∏∑';
my $desc = 'Honey bunches of oats!';

TODO:
{
throws_ok(
    sub { Games::Framework::RCP::Data::Classes::insert_job_class() },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Confirm a name must be provided for a class.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::insert_job_class('') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Confirm a name of at least one character must be provided for a class.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::insert_job_class($name) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Confirm a description must be provided for a class.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::insert_job_class($name, '') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Confirm a description of at least one character must be provided for a class.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::insert_job_class($name, $desc, 'boss') },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Confirm a job kind must be either an integer or undef.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::insert_job_class($name, $desc, 1, 'hero') },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Confirm job stats must be either a hash or undef.'
);

ok(
    Games::Framework::RCP::Data::Classes::insert_job_class($name, $desc),
    'Make sure the class was not added accidentally previously.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::insert_job_class($name, $desc) },
    'Games::Framework::RCP::Exceptions::Database::Non_Unique',
    'Make sure the class was not added accidentally previously.'
);

my $id = Games::Framework::RCP::Data::Classes::select_job_id_by_name($name);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_name_by_name($name . "bah") },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update classes that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_name_by_id($id + 9000) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update classes that do not exist.'
);

Games::Framework::RCP::Data::Classes::insert_job_class('Dummy', $desc);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_name_by_name($name, 'Dummy') },
    'Games::Framework::RCP::Exceptions::Database::Non_Unique',
    'Make sure you cannot update a job name to one that exists.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_name_by_id($id, 'Dummy') },
    'Games::Framework::RCP::Exceptions::Database::Non_Unique',
    'Make sure you cannot update a job name to one that exists.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_desc_by_name($name . 'bah') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update job descriptions that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_desc_by_id($id . 9000) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update job descriptions that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_desc_by_name($name) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'The description must be filled in!'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_desc_by_id($id) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'The description must be filled in!'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_desc_by_name($name, '') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'The description must be filled in!'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_desc_by_id($id, '') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'The description must be filled in!'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_kind_by_name($name . 'bah') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update job kinds that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_kind_by_id($id . 9000) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update job kinds that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_kind_by_name($name) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A job kind requires an integer.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_kind_by_id($id) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A job kind requires an integer.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_name($name . 'bah') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update job stats that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_id($id . 9000) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot update job stats that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_name($name) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A stat change requires a valid column.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_id($id) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A stat change requires a valid column.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_name($name, 'nope') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'A stat change requires a valid column.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_id($id, 'nope') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'A stat change requires a valid column.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_name($name, 'hp') },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A stat change requires a valid value.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::update_job_stat_by_id($id, 'hp') },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A stat change requires a valid value.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_desc_by_name($name . 'bah'),
    undef,
    'Make sure you cannot select job descriptions that do not exist.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_desc_by_id($id . 9000),
    undef,
    'Make sure you cannot select job descriptions that do not exist.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_kind_by_name($name . 'bah'),
    undef,
    'Make sure you cannot select job kinds that do not exist.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_kind_by_id($id . 9000),
    undef,
    'Make sure you cannot select job kinds that do not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::select_job_stat_by_name($name . 'bah') },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A column must be provided to get a stat.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::select_job_stat_by_id($id . 9000) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'A column must be provided to get a stat.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::select_job_stat_by_name($name . 'bah', 'hi') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'A valid column must be provided to get a stat.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::select_job_stat_by_id($id . 9000, 'hi') },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'A valid column must be provided to get a stat.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_stat_by_name($name . 'bah', 'hp'),
    undef,
    'Make sure you cannot select job stats that do not exist.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_stat_by_id($id . 9000, 'hp'),
    undef,
    'Make sure you cannot select job stats that do not exist.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_info_by_name($name . 'bah'),
    undef,
    'Make sure you cannot select job info that do not exist.'
);

is(
    Games::Framework::RCP::Data::Classes::select_job_info_by_id($id . 9000),
    undef,
    'Make sure you cannot select job info that do not exist.'
);


Games::Framework::RCP::Data::Classes::delete_job_by_id($id);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::delete_job_by_id($id) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot delete a job class by ID that does not exist.'
);

throws_ok(
    sub { Games::Framework::RCP::Data::Classes::delete_job_by_name($name) },
    'Games::Framework::RCP::Exceptions::Database::Non_Existant',
    'Make sure you cannot delete a job class by name that does not exist.'
);

};
$dbh->rollback();
