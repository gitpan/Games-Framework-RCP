# $Revision: 0.07 $
# $Date: Sat Dec 26 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Utilities/Vars_Bool.pm $

package Games::Framework::RCP::Utilities::Vars_Bool;

use 5.010;

use warnings;
use strict;
use utf8;
use Games::Framework::RCP::Database;

our $VERSION = '0.07';

sub insert_boolean_variable {
    my ( $name, $value ) = @_;
    
    if (defined select_boolean_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Unique->throw
        (
            error => "The value $name is already in the name column in the utilities.vars_bool table."
        );
    }
    
    my ( $sql,  $sth )   = undef;
    my $dbh = Games::Framework::RCP::Database->instance();
    
    $sql = 'INSERT INTO utilities.vars_bool (name, value) VALUES (?, ?)';
    $sth = $dbh->prepare($sql);
    $sth->execute( $name, $value );
    return 1;
}

sub update_boolean_variable_value_by_id {
    my ( $id,  $value ) = @_;
    
    unless (defined select_boolean_variable_value_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no record of ID value $id in the utilities.vars_bool table."
        );
    }
    
    my ( $sql, $sth )   = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_bool SET value = ? WHERE id_variable = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $value, $id );
    return 1;
}

sub update_boolean_variable_value_by_name {
    my ( $name, $value ) = @_;
    
    unless (defined select_boolean_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no record of the $name variable being in the utilities.vars_bool table."
        );
    }
    
    my ( $sql,  $sth )   = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_bool SET value = ? WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $value, $name );
    return 1;
}

sub invert_boolean_variable_by_name {
    my ( $name ) = @_;
    
    unless (defined select_boolean_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no record of the $name variable being in the utilities.vars_bool table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_bool SET value = NOT value WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);
    return 1;
}

sub invert_boolean_variable_by_id {
    my ( $id ) = @_;
    
    unless (defined select_boolean_variable_value_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no record of ID value $id in the utilities.vars_bool table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = <<'END';
        UPDATE utilities.vars_bool SET value = NOT value
        WHERE id_variable = ?
END
    $sth = $dbh->prepare($sql);
    $sth->execute($id);
    return 1;
}

sub invert_all_boolean_variables {
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'UPDATE utilities.vars_bool SET value = NOT value';
    $sth = $dbh->prepare($sql);
    $sth->execute();
    return 1;
}

sub delete_boolean_variable_by_name {
    my ( $name ) = @_;
    
    unless (defined select_boolean_variable_value_by_name($name))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no record of the $name variable in the utilities.vars_bool table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'DELETE FROM utilities.vars_bool WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);
    return 1;
}

sub delete_boolean_variable_by_id {
    my ( $id ) = @_;
    
    unless (defined select_boolean_variable_value_by_id($id))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Existant->throw
        (
            error => "There is no record of ID value $id in the utilities.vars_bool table."
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'DELETE FROM utilities.vars_bool WHERE id_variable = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);
    return 1;
}

sub select_boolean_variable_value_by_name {
    my ( $name ) = @_;
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT value FROM utilities.vars_bool WHERE name = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($name);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{value};
    }
    return;
}

sub select_boolean_variable_value_by_id {
    my ( $id ) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT value FROM utilities.vars_bool WHERE id_variable = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{value};
    }
    return;
}

sub select_id_by_boolean_variable {
    my ($name) = @_;
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();
    
    $sql = 'SELECT id_variable FROM utilities.vars_bool WHERE name = ?';
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

Games::Framework::RCP::Utilities::Vars_Bool - Subroutines for the vars_bool Table.

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

=item *

L<Games::Framework::RCP::Exceptions|Games::Framework::RCP::Exceptions>

=back

=head1 SYNOPSIS

Games::Framework::RCP::Utilities::Vars_Bool - A listing of the different subroutines
that one can use to manipulate boolean variables.

=head1 DESCRIPTION

This module contains various functions used to manipulate the vars_bool table.
One can insert, delete, update, and select various boolean variable names
and values.  Note that it is recommended to not delete the particular
variables.

=head1 CONFIGURATION AND ENVIRONMENT

No configuration should be required.

=head1 SUBROUTINES/METHODS

=head2 insert_boolean_variable

This function is used to insert a new variable that takes a boolean value.
Any new variables created are inaccessible until either coded in the modules
or your own driver program.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=item * $_[1]

the value of the variable.  It defaults to 0 if nothing is provided.

=back

Returns "taken" if that variable name is already in use.

=head2 update_boolean_variable_value_by_name

This function takes a boolean variable's name to update its value.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=item * $_[1]

the new value.

=back

=head2 update_boolean_variable_value_by_id

This function takes a boolean variable's ID to update its value.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=item * $_[1]

the new value.

=back

=head2 invert_boolean_variable_by_name

This function inverts a boolean variable's value, given a name.
It is provided as a convenience to Game Masters.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=back

=head2 invert_boolean_variable_by_id

This function inverts a boolean variable's value, given an ID.
It is provided as a convenience to Game Masters.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=back

=head2 invert_all_boolean_variables

This function inverts all of the integer variables' values.
It is provided as a convenience to Game Masters.

There are no parameters in this function.

=head2 delete_boolean_variable_by_name

This function removes a boolean variable based off of its name.
It is recommended to NEVER call this function: however, it
is provided just in case someone wants to have fun with it.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=back

=head2 delete_boolean_variable_by_id

This function removes a boolean variable based off of its ID.
It is recommended to NEVER call this function: however, it
is provided just in case someone wants to have fun with it.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=back

=head2 select_boolean_variable_value_by_name

This function is available to get the value of a boolean variable
by its name.

The parameters are as follows:

=over 4

=item * $_[0]

the name of the variable.

=back

Return the value of the variable if it was selected.

=head2 select_boolean_variable_value_by_id

This function is available to get the value of a boolean variable
by its ID.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the variable.

=back

Return the value of the variable if it was selected.

=head2 select_id_by_boolean_variable

This function returns the ID of the specific boolean variable.

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
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Utilities-Vars_Bool>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Utilities::Vars_Bool


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Utilities-Vars_Bool>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Utilities-Vars_Bool>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Utilities-Vars_Bool>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Utilities-Vars_Bool/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
