#!perl -T

use Test::More tests => 1;

unless (defined $ENV{DB_TEST_USERNAME} and $ENV{DB_TEST_PASSWORD})
{
	BAIL_OUT('You must define $ENV{DB_TEST_USERNAME} and $ENV{DB_TEST_PASSWORD} to run the database tests!');
}

pass('Environmental variables defined.  Database access/manipulation tests can begin.');