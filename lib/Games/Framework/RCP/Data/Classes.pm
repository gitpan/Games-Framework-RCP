# $Revision: 0.01_01 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Data/Classes.pm $

package Games::Framework::RCP::Data::Classes;

use 5.010;

use warnings;
use strict;
use utf8;
use Encode;

use Scalar::Util::Numeric qw(isint isnum);
use Readonly;

use Games::Framework::RCP::Database;

my @columns =
(
    'hp',   'mp',   'pp',   'spd',
    'patk', 'matk', 'pdef', 'mdef',
    'pacc', 'macc', 'pevd', 'mevd'
);

our $VERSION = '0.01_01';

## no critic
Readonly::Scalar my $DEFAULT_STAT_VALUE => 50;
## use critic

sub insert_job_class {
    my ( $name, $desc, $kind, $stats ) = @_;
    
    unless (defined $name and length $name)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => 'The name of the job must be defined!'
        );
    }
    
    if (defined select_job_id_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Unique->throw
        (
            error => "The $name job is already in the database!"
        );
    }
    
    unless (defined $desc and length $desc)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => 'The description of the job must be defined!'
        );
    }
    
    if (defined $kind and not isint($kind))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The kind variable must either be an integer or undefined.'
        );
    }
    
    if (defined $stats and ref $stats ne 'HASH')
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The stats variable must either be a hash or undefined.'
        );
    }
    
    my ($hp,   $mp,   $pp,   $spd,  $patk, $matk, $pdef,
        $mdef, $pacc, $macc, $pevd, $mevd, $sql,  $sth
    ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $kind //= 1;    # / # Syntax highlighting fix.

    $hp = $stats->{hp};
    unless (defined $hp)
    {
        $hp = $DEFAULT_STAT_VALUE;
    }

    $mp = $stats->{mp};
    unless (defined $mp)
    {
        $mp = $DEFAULT_STAT_VALUE;
    }
    
    $pp = $stats->{pp};
    unless (defined $pp)
    {
        $pp = $DEFAULT_STAT_VALUE;
    }
    
    $spd = $stats->{spd};
    unless (defined $spd)
    {
        $spd = $DEFAULT_STAT_VALUE;
    }
    
    $patk = $stats->{patk};
    unless (defined $patk)
    {
        $patk = $DEFAULT_STAT_VALUE;
    }
    
    $matk = $stats->{matk};
    unless (defined $matk)
    {
        $matk = $DEFAULT_STAT_VALUE;
    }
    
    $pdef = $stats->{pdef};
    unless (defined $pdef)
    {
        $pdef = $DEFAULT_STAT_VALUE;
    }
    
    $mdef = $stats->{mdef};
    unless (defined $mdef)
    {
        $mdef = $DEFAULT_STAT_VALUE;
    }
    
    $pacc = $stats->{pacc};
    unless (defined $pacc)
    {
        $pacc = $DEFAULT_STAT_VALUE;
    }
    
    $macc = $stats->{macc};
    unless (defined $macc)
    {
        $macc = $DEFAULT_STAT_VALUE;
    }
    
    $pevd = $stats->{pevd};
    unless (defined $pevd)
    {
        $pevd = $DEFAULT_STAT_VALUE;
    }
    
    $mevd = $stats->{mevd};
    unless (defined $mevd)
    {
        $mevd = $DEFAULT_STAT_VALUE;
    }
    
    $sql = <<'END';
INSERT INTO data.classes
(
    name, description, kind, hp, mp, pp, spd,
    patk, matk, pdef, mdef, pacc, macc, pevd, mevd
)
VALUES
(
    ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?
)
END
    $sth = $dbh->prepare($sql);
    $sth->execute(
        $name, $desc, $kind, $hp,   $mp,   $pp,   $spd, $patk,
        $matk, $pdef, $mdef, $pacc, $macc, $pevd, $mevd
    );
    return 1;
}

sub delete_job_by_name {
    my ($name) = @_;
    
    unless (defined select_job_id_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The $name job is not in the database."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'DELETE FROM data.classes WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);
    return 1;
}

sub delete_job_by_id {
    my ($id) = @_;
    
    unless (defined select_job_name_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no job with ID $id in the database."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'DELETE FROM data.classes WHERE id_job = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);
    return 1;
}

sub update_job_name_by_name {
    my ( $old, $new ) = @_;
    
    unless (defined select_job_id_by_name($old))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The $old job is not in the database."
        );
    }
    
    if (defined select_job_id_by_name($new))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Unique->throw
        (
            error => "The $new job is already in the database."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE data.classes SET name = ? WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $new, $old );
    return 1;
}

sub update_job_name_by_id {
    my ( $id,  $new ) = @_;
    
    unless (defined select_job_name_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no job with ID $id in the database."
        );
    }
    
    if (defined select_job_id_by_name($new))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Unique->throw
        (
            error => "The $new job is already in the database."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE data.classes SET name = ? WHERE id_job = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $new, $id );
    return 1;
}

sub update_job_desc_by_name {
    my ( $name, $desc ) = @_;
    
    unless (defined select_job_id_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no job named $name in the database."
        );
    }
    
    unless (defined $desc and length $desc)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => 'The description of the job must be defined!'
        );
    }
    
    my ( $sql,  $sth )  = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE data.classes SET description = ? WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $desc, $name );
    return 1;
}

sub update_job_desc_by_id {
    my ( $id,  $desc ) = @_;
    
    unless (defined select_job_name_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no job with ID $id in the database."
        );
    }
    
    unless (defined $desc and length $desc)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => 'The description of the job must be defined!'
        );
    }
    
    my ( $sql, $sth )  = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE data.classes SET description = ? WHERE id_job = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $desc, $id );
    return 1;
}

sub update_job_kind_by_name {
    my ( $name, $kind ) = @_;
    
    unless (defined select_job_id_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no job named $name in the database."
        );
    }
    
    unless (isint($kind))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The kind variable must be an integer.'
        );
    }
    
    my ( $sql,  $sth )  = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE data.classes SET kind = ? WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $kind, $name );
    return 1;
}

sub update_job_kind_by_id {
    my ( $id,  $kind ) = @_;
    
    unless (defined select_job_name_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no job with ID $id in the database."
        );
    }
    
    unless (isint($kind))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The kind variable must be an integer.'
        );
    }
    
    my ( $sql, $sth )  = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE data.classes SET kind = ? WHERE id_job = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $kind, $id );
    return 1;
}

sub update_job_stat_by_name {
    my ( $name, $stat, $value ) = @_;
    
    unless (defined select_job_id_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no $name job in the database."
        );
    }
    
    unless (defined $stat)
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The stat variable must be defined!'
        );
    }
    
    unless ($stat ~~ @columns)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no $stat column in the database."
        );
    }
    
    unless (isnum($value))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The value variable must be a number.'
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = "UPDATE data.classes SET $stat = ? WHERE name = ?";
    $sth = $dbh->prepare($sql);
    $sth->execute( $value, $name );
    return 1;
}

sub update_job_stat_by_id {
    my ( $id, $stat, $value ) = @_;
    
    unless (defined select_job_name_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no job with ID $id in the database."
        );
    }
    
    unless (defined $stat)
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The stat variable must be defined!'
        );
    }
    
    unless ($stat ~~ @columns)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no $stat column in the database."
        );
    }
    
    unless (isnum($value))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The value variable must be a number.'
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = "UPDATE data.classes SET $stat = ? WHERE id_job = ?";
    $sth = $dbh->prepare($sql);
    $sth->execute( $value, $id );
    return 1;
}

sub select_job_id_by_name {
    my ($name) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT id_job FROM data.classes WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{id_job};
    }
    return;
}

sub select_job_name_by_id {
    my ($id) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT name FROM data.classes WHERE id_job = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return decode('utf8', $row->{name});
    }
    return;
}

sub select_job_desc_by_name {
    my ($name) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT description FROM data.classes WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return decode('utf8', $row->{description});
    }
    return;
}

sub select_job_desc_by_id {
    my ($id) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT description FROM data.classes WHERE id_job = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return decode('utf8', $row->{description});
    }
    return;
}

sub select_job_kind_by_name {
    my ($name) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT kind FROM data.classes WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{kind};
    }
    return;
}

sub select_job_kind_by_id {
    my ($id) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT kind FROM data.classes WHERE id_job = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{kind};
    }
    return;
}

sub select_job_stat_by_name {
    my ( $name, $stat ) = @_;
    
    unless (defined $stat)
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The stat variable must be defined!'
        );
    }
    
    unless ($stat ~~ @columns)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no $stat column in the database."
        );
    }
    
    my ( $sql,  $sth )  = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = "SELECT $stat FROM data.classes WHERE name = ?";
    $sth = $dbh->prepare($sql);
    $sth->execute($name);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{$stat};
    }
    return;
}

sub select_job_stat_by_id {
    my ( $id,  $stat ) = @_;
    
    unless (defined $stat)
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => 'The stat variable must be defined!'
        );
    }
    
    unless ($stat ~~ @columns)
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no $stat column in the database."
        );
    }
    
    my ( $sql, $sth )  = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = "SELECT $stat FROM data.classes WHERE id_job = ?";
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{$stat};
    }
    return;
}

sub select_job_info_by_name {
    my ($name) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = <<'END';
SELECT id_job, name, description, kind, hp, mp, pp, spd,
patk, matk, pdef, mdef, pacc, macc, pevd, mevd
FROM data.classes WHERE name = ?
END
    $sth = $dbh->prepare($sql);
    $sth->execute($name);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row;
    }
    return;
}

sub select_job_info_by_id {
    my ($id) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = <<'END';
SELECT id_job, name, description, kind, hp, mp, pp, spd,
patk, matk, pdef, mdef, pacc, macc, pevd, mevd
FROM data.classes WHERE id_job = ?
END
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row;
    }
    return;
}

1;

__END__

=head1 DISCLAIMER

This software is currently under development.  It is not done.
While it will not be done quickly, contributions can help
make things go faster.  Please contribute if you can.

=head1 NAME

Games::Framework::RCP::Data::Classes - Subroutines for the Classes table.

=head1 VERSION

Version 0.01_01

=head1 DEPENDENCIES

The requirements for this module are as follows:

=over 4

=item *

Perl 5.10 or higher

=item *

L<DBI|DBI>

=item *

L<Games::Framework::RCP::Database|Games::Framework::RCP::Database>

=item *

L<Readonly|Readonly>

=back

=head1 SYNOPSIS

Games::Framework::RCP::Data::Classes - A listing of the different subroutines
that one can use to manipulate the job classes.

=head1 DESCRIPTION

This module contains the basic functions for inserting, deleting, updating,
or selecting classes and/or class stats.  This module does NOT handle
what status effects a class may start with at the beginning, for instance.

=head1 CONFIGURATION AND ENVIRONMENT

No configuration should be required.

=head1 SUBROUTINES/METHODS

=head2 insert_job_class

This function is for game masters to add a new job class
to the database.  This function only handles the information
within the data.classes table.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the new job class.  Please keep within 32 characters.  This is required.

=item * $_[1]

The description of the new job class.  Please keep within 256 characters.  This is required.

=item * $_[2]

The kind of job: hero usable, unlockable, boss only, etc.  Integers are used here (numbers below are subject to change):

=over 8

=item * 1

Normal class: anyone can use it.

=item * 2

Locked class: players must earn it, almost anyone else can use it.

=item * 3

Boss class: Game Masters use it, players generally can't.

=item * -1

Penalty class: anyone can use it...but why?  Can be administered for various reasons.

=back

=item * $_[3]

The C<$stats> hash reference.  It can contain the following stats:

=over 8

=item * hp

HP of the job.

=item * mp

MP of the job.

=item * pp

PP of the job.

=item * spd

Speed of the job.

=item * patk

Physical Attack

=item * matk

Magical Attack

=item * pdef

Physical Defense

=item * mdef

Magical Defense

=item * pacc

Physical Accuracy

=item * macc

Magical Accuracy

=item * pevd

Physical Evade

=item * mevd

Magical Evade

=back

For any stat that is missing, the default value of 50 is provided.

=back

=head2 delete_job_by_name

Remove a job from the database by its name PERMAMENTLY.  Use this at your own risk!

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=back

=head2 delete_job_by_id

Remove a job from the database by its ID PERMAMENTLY.  Use this at your own risk!

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=back

=head2 update_job_name_by_name

Update a job's name based on the old name.

The parameters are as follows:

=over 4

=item * $_[0]

The old name of the job.

=item * $_[1]

The new name of the job.

=back

=head2 update_job_name_by_id

Update a job's name based on the ID.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=item * $_[1]

The new name of the job.

=back

=head2 update_job_desc_by_name

Update a job's description by its name.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=item * $_[1]

The description of the job.

=back

=head2 update_job_desc_by_id

Update a job's description by its ID.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=item * $_[1]

The description of the job.

=back

=head2 update_job_kind_by_name

Update a job's kind (playability) by its name.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=item * $_[1]

The kind of job.

=back

=head2 update_job_kind_by_id

Update a job's kind (playability) by its ID.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=item * $_[1]

The kind of job.

=back

=head2 update_job_stat_by_name

Update a job stat's value by its name.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=item * $_[1]

The stat to update.

=item * $_[2]

The value of the new stat.

=back

=head2 update_job_stat_by_id

Update a job stat's value by its ID.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=item * $_[1]

The stat to update.

=item * $_[2]

The value of the new stat.

=back

=head2 select_job_id_by_name

Select the job ID based on the job name given.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=back

=head2 select_job_name_by_id

Select the job name based on the job ID given.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=back

=head2 select_job_desc_by_name

Select the job description based on the job name given.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=back

=head2 select_job_desc_by_id

Select the job description based on the job ID given.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=back

=head2 select_job_kind_by_name

Select the job kind (playability) based on the job name given.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=back

=head2 select_job_kind_by_id

Select the job kind (playability) based on the job ID given.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=back

=head2 select_job_stat_by_name

Select the job stat based on the job name given.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=item * $_[1]

The stat of the job.

=back

=head2 select_job_stat_by_id

Select the job stat based on the job ID given.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=item * $_[1]

The stat of the job.

=back

=head2 select_job_info_by_name

Get every column of data related to the job by its name.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the job.

=back

=head2 select_job_info_by_id

Get every column of data related to the job by its ID.

The parameters are as follows:

=over 4

=item * $_[0]

The ID of the job.

=back

=head1 INCOMPATIBILITIES

There are no known incompatibilities in this module.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Data-Classes>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Data::Classes


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Data-Classes>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Data-Classes>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Data-Classes>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Data-Classes/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
