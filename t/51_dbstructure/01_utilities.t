#!perl -T

use Test::More;

BEGIN {
    $num_test = 32;
    eval 'use Test::DBUnit 0.17';
    
    if ( $@ ) {
        plan skip_all => 'Install Test::DBUnit >= 0.17 for these tests.';
    } else {
        eval 'use DBIx::Connection 0.12';
        if ( $@ ) {
            plan skip_all => 'Install DBIx::Connection >= 0.12 for these tests.';
        } else {
            use Test::DBUnit dsn => 'dbi:Pg:dbname=rcp;host=localhost;port=5432', username => $ENV{DB_TEST_USERNAME}, password => $ENV{DB_TEST_PASSWORD};
            
            plan tests => $num_test;
        }
    }
}

my $conection = test_connection();
my $dbh = test_dbh();

$dbh->begin_work();

my $num_pass = 0;

my @cols = ("id_color", "fg", "bg");

$num_pass += has_table("utilities", "colors", "Confirming utilities.colors exists.");
$num_pass += has_columns("utilities", "colors", \@cols, "Confirming id_color, fg, and bg columns exist.");
$num_pass += has_pk("utilities", "colors", "id_color", "Confirming id_order is primary key.");
$num_pass += has_index("utilities", "colors", "colors_pkey", "Confirming an index in utilities.colors.");
$num_pass += index_is_unique("utilities", "colors", "colors_pkey", "Confirming colors_pkey is unique.");

foreach (@cols)
{
    $num_pass += column_is_not_null("utilities", "colors", $_, "Confirm the $_ column has NOT NULL.");
}

my @tables = ("vars_bool", "vars_ints", "vars_real");
@cols = ("id_variable", "name", "value");

foreach my $table (@tables)
{
    my $uniq = $table . "_" . $cols[1] . "_key";
    $num_pass += has_table("utilities", $table, "Confirming utilities.$table exists.");
    $num_pass += has_columns("utilities", $table, \@cols, "Confirming the specified columns exist.");
    $num_pass += has_pk("utilities", $table, $cols[0], "Confirming $cols[0] is primary key.");
    $num_pass += has_index("utilities", $table, $uniq, "Confirming an index in column $cols[1].");
    $num_pass += index_is_unique("utilities", $table, $uniq, "Confirming $cols[1] is unique.");
    
    foreach (@cols)
    {
        $num_pass += column_is_not_null("utilities", $table, $_, "Confirm the $_ column has NOT NULL.");
    }
}

$dbh->rollback();

if ($num_pass != $num_test)
{
    BAIL_OUT("The Database structure is comrpomised!  No more testing is possible!");
}
