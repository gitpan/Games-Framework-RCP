# $Revision: 0.07 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Utilities/Vars_Ints.pm $

package Games::Framework::RCP::Utilities::Vars_Ints;

use 5.010;

use warnings;
use strict;
use utf8;

use Scalar::Util::Numeric qw(isint);

use Games::Framework::RCP::Database;

our $VERSION = '0.07';

sub insert_integer_variable {
    my ( $name, $value ) = @_;
    
    if (defined select_integer_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Unique->throw
        (
            error => "The variable $name is already in the name column in the utilities.vars_ints table."
        );
    }
    
    unless (isint($value))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "The value $value is not an integer."
        );
    }
    
    my ( $sql,  $sth )   = undef;
    my $dbh = Games::Framework::RCP::Database->instance();
    
    $sql = 'INSERT INTO utilities.vars_ints (name, value) VALUES (?, ?)';
    $sth = $dbh->prepare($sql);
    $sth->execute( $name, $value );
    return 1;
}

sub update_integer_variable_value_by_id {
    my ( $id,  $value ) = @_;
    
    unless (defined select_integer_variable_value_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The ID $id does not exist in the utilities.vars_ints table."
        );
    }
    
    unless (isint($value))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "The value $value is not an integer."
        );
    }
    
    my ( $sql, $sth )   = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_ints SET value = ? WHERE id_variable = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $value, $id );
    return 1;
}

sub update_integer_variable_value_by_name {
    my ( $name, $value ) = @_;
    
    unless (defined select_integer_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The variable $name is not in the utilities.vars_ints table."
        );
    }
    
    unless (isint($value))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "The value $value is not an integer."
        );
    }
    
    my ( $sql,  $sth )   = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_ints SET value = ? WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $value, $name );
    return 1;
}

sub invert_integer_variable_by_name {
    my ($name) = @_;
    
    unless (defined select_integer_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The variable $name is not in the utilities.vars_ints table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_ints SET value = value * -1 WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);
    return 1;
}

sub invert_integer_variable_by_id {
    my ($id) = @_;
    
    unless (defined select_integer_variable_value_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The ID $id is not in the utilities.vars_ints table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = <<'END';
        UPDATE utilities.vars_ints SET value = value * -1
        WHERE id_variable = ?
END
    $sth = $dbh->prepare($sql);
    $sth->execute($id);
    return 1;
}

sub invert_all_integer_variables {
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_ints SET value = value * -1';
    $sth = $dbh->prepare($sql);
    $sth->execute();
    return 1;
}

sub delete_integer_variable_by_name {
    my ( $name ) = @_;
    
    unless (defined select_integer_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The variable $name is not in the utilities.vars_ints table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'DELETE FROM utilities.vars_ints WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);
    return 1;
}

sub delete_integer_variable_by_id {
    my ( $id ) = @_;
    
    unless (defined select_integer_variable_value_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "The ID $id is not in the utilities.vars_ints table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'DELETE FROM utilities.vars_ints WHERE id_variable = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);
    return 1;
}

sub select_integer_variable_value_by_name {
    my ( $name ) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT value FROM utilities.vars_ints WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{value};
    }
    return;
}

sub select_integer_variable_value_by_id {
    my ( $id ) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT value FROM utilities.vars_ints WHERE id_variable = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{value};
    }
    return;
}

sub select_id_by_integer_variable {
    my ($name) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();
    
    $sql = 'SELECT id_variable FROM utilities.vars_ints WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);
    
    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{id_variable};
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

Games::Framework::RCP::Utilities::Vars_Ints - Subroutines for the vars_ints Table.

=head1 VERSION

Version 0.07

=head1 DEPENDENCIES

The requirements for this module are as follows:

=over 4

=item *

Perl 5.10 or higher

=item *

L<DBI|DBI>

=item *

L<Games::Framework::RCP::Database|Games::Framework::RCP::Database>

=back

=head1 SYNOPSIS

Games::Framework::RCP::Utilities::Vars_Ints - A listing of the different subroutines
that one can use to manipulate integer variables.

=head1 DESCRIPTION

This module contains various functions used to manipulate the vars_ints table.
One can insert, delete, update, and select various integer variable names
and values.  Note that it is recommended to not delete the particular
variables.

=head1 CONFIGURATION AND ENVIRONMENT

No configuration should be required.

=head1 SUBROUTINES/METHODS

=head2 insert_integer_variable

This function is used to insert a new variable that takes a integer value.
Any new variables created are inaccessible until either coded in the modules
or your own driver program.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=item * $_[1]

the value of the variable.  It defaults to 0 if nothing is provided.

=back

=head2 update_integer_variable_value_by_name

This function takes a integer variable's name to update its value.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=item * $_[1]

the new value.

=back

=head2 update_integer_variable_value_by_id

This function takes a integer variable's ID to update its value.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=item * $_[1]

the new value.

=back

=head2 invert_integer_variable_by_name

This function inverts a integer variable's value, given a name.
It is provided as a convenience to Game Masters.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=back

=head2 invert_integer_variable_by_id

This function inverts a integer variable's value, given an ID.
It is provided as a convenience to Game Masters.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=back

=head2 invert_all_integer_variables

This function inverts all of the integer variables' values.
It is provided as a convenience to Game Masters.

There are no parameters in this function.

=head2 delete_integer_variable_by_name

This function removes a integer variable based off of its name.
It is recommended to NEVER call this function: however, it
is provided just in case someone wants to have fun with it.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=back

=head2 delete_integer_variable_by_id

This function removes a integer variable based off of its ID.
It is recommended to NEVER call this function: however, it
is provided just in case someone wants to have fun with it.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=back

=head2 select_integer_variable_value_by_name

This function is available to get the value of a integer variable
by its name.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=back

Return the value of the variable if it was selected.

=head2 select_integer_variable_value_by_id

This function is available to get the value of a integer variable
by its ID.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=back

Return the value of the variable if it was selected.

=head2 select_id_by_integer_variable

This function returns the ID of the specific integer variable.

The parameters are as follows:

=over 4

=item * $_[0]

The name of the variable.

=back

Returns the ID of the variable if it exists.

=head1 INCOMPATIBILITIES

There are no known incompatibilities in this module.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Utilities-Vars_Ints>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Utilities::Vars_Ints


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Utilities-Vars_Ints>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Utilities-Vars_Ints>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Utilities-Vars_Ints>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Utilities-Vars_Ints/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
