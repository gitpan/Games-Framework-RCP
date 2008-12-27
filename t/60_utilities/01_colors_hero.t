#!perl -T

use Test::More;
use Games::Framework::RCP::Utilities::Colors;

plan tests => 519;
my $dbh = Games::Framework::RCP::Database->instance
({
	user => $ENV{DB_TEST_USERNAME},
	pass => $ENV{DB_TEST_PASSWORD}
});

$dbh->begin_work();

my $col_a = 25;
my $col_b = 25;

is( Games::Framework::RCP::Utilities::Colors::insert_color_combo($col_a, $col_b), 1, "Verify inserting a color can work.");

my $id = Games::Framework::RCP::Utilities::Colors::select_id_by_color_combo($col_a, $col_b);

is_deeply( Games::Framework::RCP::Utilities::Colors::select_color_combo_by_id($id), { fg => $col_a, bg => $col_b }, "Verify the same colors we just put in.");

is( Games::Framework::RCP::Utilities::Colors::update_color_combo($id, $col_a, ++$col_b), 1, "Verify updating colors can work.");

is( Games::Framework::RCP::Utilities::Colors::select_id_by_color_combo($col_a, $col_b), $id, "Confirm ID is still the same despite color change.");

is( Games::Framework::RCP::Utilities::Colors::delete_color_combo($id), 1, "Confirm we can remove colors.");

is (Games::Framework::RCP::Utilities::Colors::select_id_by_color_combo($col_a, $col_b), undef, "Confirm the previous color was removed.");
is (Games::Framework::RCP::Utilities::Colors::select_color_combo_by_id($id), undef, "Confirm the previous color was removed.");

$dbh->rollback();

for my $x (0..15)
{
    for my $y (0..15)
    {
        is( Games::Framework::RCP::Utilities::Colors::select_id_by_color_combo($x, $y), ($x * 16 + $y), "Confirm original IDs match original color specs.");
        is_deeply( Games::Framework::RCP::Utilities::Colors::select_color_combo_by_id($x * 16 + $y), { fg => $x, bg => $y }, "Confirm original IDs match original color specs.");
    }
}