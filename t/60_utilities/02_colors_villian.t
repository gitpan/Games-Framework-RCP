#!perl -T

use Test::More;
use Games::Framework::RCP::Utilities::Colors;

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

my $col_a = 25;
my $col_b = 25;

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::insert_color_combo("jawnsy", 1) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::insert_color_combo(1, "apieron") },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::insert_color_combo(1, 1) },
    'Games::Framework::RCP::Exceptions::Database::Non_Unique',
    'Colors must be unique.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::update_color_combo("pkrumins", 1, 0) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::update_color_combo(1, "Zoffix", 0) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::update_color_combo(1, 0, "rindolf") },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::update_color_combo(1, 1, 1) },
    'Games::Framework::RCP::Exceptions::Database::Non_Unique',
    'Colors must be unique.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::delete_color_combo("Apocalypse") },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::select_id_by_color_combo("kent\\n", 1) },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::select_id_by_color_combo(1, "buu") },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

throws_ok(
    sub { Games::Framework::RCP::Utilities::Colors::select_color_combo_by_id("Khisanth") },
    'Games::Framework::RCP::Exceptions::Database::Invalid_Type',
    'Colors must be integers.'
);

$dbh->rollback();
