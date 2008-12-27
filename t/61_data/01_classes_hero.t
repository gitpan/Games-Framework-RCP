#!perl -T

use utf8;
use Test::More;
use Games::Framework::RCP::Data::Classes;
use Encode;

plan tests => 74;
my $dbh = Games::Framework::RCP::Database->instance
({
	user => $ENV{DB_TEST_USERNAME},
	pass => $ENV{DB_TEST_PASSWORD}
});

$dbh->begin_work();

my $name  = '∅∆∏∑';
my $desc = 'Honey bunches of oats!';

my @columns =
(
    'hp',   'mp',   'pp',   'spd',
    'patk', 'matk', 'pdef', 'mdef',
    'pacc', 'macc', 'pevd', 'mevd'
);

is
(
    Games::Framework::RCP::Data::Classes::insert_job_class($name, $desc),
    1,
    encode("utf8", "Insert the $name job with basic stats.")
);

my $id = Games::Framework::RCP::Data::Classes::select_job_id_by_name($name);

$name .= 'bah';

is
(
    Games::Framework::RCP::Data::Classes::update_job_name_by_id($id, $name),
    1,
    "Verify updating job names by ID can work."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_name_by_id($id),
    $name,
    "Confirm value updates."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_id_by_name($name),
    $id,
    "Confirm the ID is still the same."
);

$desc .= 'oy';

is
(
    Games::Framework::RCP::Data::Classes::update_job_desc_by_id($id, $desc),
    1,
    "Verify updating job descriptions by ID can work."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_desc_by_id($id),
    $desc,
    "Confirm value updates."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_id_by_name($name),
    $id,
    "Confirm the ID is still the same."
);

is
(
    Games::Framework::RCP::Data::Classes::update_job_kind_by_id($id, 2),
    1,
    "Verify updating job kinds by ID can work."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_kind_by_id($id),
    2,
    "Confirm value updates."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_id_by_name($name),
    $id,
    "Confirm the ID is still the same."
);

foreach (@columns)
{
    is
    (
        Games::Framework::RCP::Data::Classes::update_job_stat_by_id($id, $_, 1),
        1,
        "Verify updating job kinds by ID can work."
    );
    is
    (
        Games::Framework::RCP::Data::Classes::select_job_stat_by_id($id, $_),
        '1.0000',
        "Confirm value updates."
    );
}

ok
(
    Games::Framework::RCP::Data::Classes::select_job_info_by_id($id),
    'Test gathering the job information.'
);

is
(
    Games::Framework::RCP::Data::Classes::delete_job_by_id($id),
    1,
    "Verify removing jobs by ID can work."
);

# Now we do everything by name.  Also, define everything.

my $stats;

foreach (@columns)
{
    $stats->{$_} = 1;
}

is
(
    Games::Framework::RCP::Data::Classes::insert_job_class($name, $desc, 2, $stats),
    1,
    encode("utf8", "Insert the $name job with sucky stats.")
);

$id = Games::Framework::RCP::Data::Classes::select_job_id_by_name($name);

$new = $name . 'humbug';

is
(
    Games::Framework::RCP::Data::Classes::update_job_name_by_name($name, $new),
    1,
    "Verify updating job names by name can work."
);

$name = $new;

is
(
    Games::Framework::RCP::Data::Classes::select_job_id_by_name($name),
    $id,
    "Confirm value updates."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_id_by_name($name),
    $id,
    "Confirm the ID is still the same."
);

$desc .= 'vey';

is
(
    Games::Framework::RCP::Data::Classes::update_job_desc_by_name($name, $desc),
    1,
    "Verify updating job descriptions by name can work."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_desc_by_name($name),
    $desc,
    "Confirm value updates."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_id_by_name($name),
    $id,
    "Confirm the ID is still the same."
);

is
(
    Games::Framework::RCP::Data::Classes::update_job_kind_by_name($name, 2),
    1,
    "Verify updating job kinds by name can work."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_kind_by_name($name),
    2,
    "Confirm value updates."
);
is
(
    Games::Framework::RCP::Data::Classes::select_job_id_by_name($name),
    $id,
    "Confirm the ID is still the same."
);

foreach (@columns)
{
    is
    (
        Games::Framework::RCP::Data::Classes::update_job_stat_by_name($name, $_, 1),
        1,
        "Verify updating job kinds by name can work."
    );
    is
    (
        Games::Framework::RCP::Data::Classes::select_job_stat_by_name($name, $_),
        '1.0000',
        "Confirm value updates."
    );
}

ok
(
    Games::Framework::RCP::Data::Classes::select_job_info_by_name($name),
    'Test gathering the job information.'
);

is
(
    Games::Framework::RCP::Data::Classes::delete_job_by_name($name),
    1,
    "Verify removing jobs by name can work."
);

is( Games::Framework::RCP::Data::Classes::select_job_id_by_name($name), undef, "Confirm the previous variable was removed.");
is( Games::Framework::RCP::Data::Classes::select_job_name_by_id($id), undef, "Confirm the previous variable was removed.");


$dbh->rollback();