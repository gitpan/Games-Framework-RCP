#!perl -T

use Test::More tests => 4;

use Games::Framework::RCP::Exceptions;

is( Games::Framework::RCP::Exceptions::Database->description(), 'Database related issues.');
is( Games::Framework::RCP::Exceptions::Database::Missing_Credentials->description(), 'Missing username or password.');
is( Games::Framework::RCP::Exceptions::Database::Non_Unique->description(), 'Violations of [uniq] or [pk].');

is
(
    Games::Framework::RCP::Exceptions::Database::Invalid_Type->description(),
    'Violations of database types.',
    'Confirming database description.'
);