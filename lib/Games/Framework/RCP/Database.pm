# $Revision: 0.01_01 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Database.pm $

package Games::Framework::RCP::Database;

use 5.010;

use warnings;
use strict;

use base qw(Class::Singleton);
## no critic
use vars qw($errstr);   # Required due to use of Singleton class.
## use critic

use DBI;
use DBD::Pg;

use Games::Framework::RCP::Exceptions;

our $VERSION = '0.01_01';

my ( $dbsys, $dbname, $host, $port ) = undef;

*errstr = *DBI::errstr;

sub _new_instance {
    my ( $class, $params ) = @_;
    my ( $user,  $pass, $data_source, $options ) = undef;

    $user = $params->{user};
    $pass = $params->{pass};
    
    unless (defined $user and defined $pass)
    {
        Games::Framework::RCP::Exceptions::Database::Missing_Credentials->throw
        (
            error => 'Either the username or password was not supplied.  Connecting to the database is not possible.'
        );
    }

    $dbsys = $params->{dbsys};
    $dbsys //= 'Pg';          # / # Syntax highlighting fix.

    $dbname = $params->{dbname};
    $dbname //= 'rcp';        # / # Syntax highlighting fix.

    $host = $params->{host};
    $host //= 'localhost';    # / # Syntax highlighting fix.

    $port = $params->{port};
    $port //= '5432';         # / # Syntax highlighting fix.

    $options = $params->{options};
    $options //= { AutoCommit => 1, RaiseError => 1,
        PrintError => 0 };    # / # Syntax highlighting fix.

    $data_source = sprintf 'dbi:%s:dbname=%s;host=%s;port=%s', $dbsys,
        $dbname, $host, $port;

    return DBI->connect( $data_source, $user, $pass, $options );
}

sub get_db_system {
    return $dbsys;
}

sub get_db_name {
    return $dbname;
}

sub get_host {
    return $host;
}

sub get_port {
    return $port;
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database - The interface to logging into the database.

=head1 VERSION

Version 0.01_01

=head1 SYNOPSIS

Games::Framework::RCP::Database - Connect to the database and use the system.

    use Games::Framework::RCP::Database;
    my $dbh = Games::Framework::RCP::Database->instance({user => "foo", pass => "bar"});

    # Actions go here.

=head1 DESCRIPTION

This module provides a proper way to connect to the database and
establish a single connection.  

=head1 CONFIGURATION AND ENVIRONMENT

The only requirements for the environment are that PostGresQL is installed.
In the future, other database systems may be supported.

=head1 DEPENDENCIES

=over 4

=item *

Perl5.10

=item *

L<DBD::Pg|DBD::Pg>
Note: in the future, more database support is planned.

=item *

L<Class::Singleton|Class::Singleton>

=back

=cut

#head1 EXPORT

#A list of functions that can be exported.  You can delete this section
#if you don't export anything, such as for a purely object-oriented module.

=head1 SUBROUTINES/METHODS

=head2 errstr

Alias DBI errors using typeglob magic.

=head2 _new_instance

This is used with L<Class::Singleton|Class::Singleton>
to ensure only one instance of a database connection is made.

Params are as follows:

=over 4

=item * $_[0]

The $class variable.  This can be ignored safely.

=item * $_[1]

The hash of $params.  It usually contains the following:

=over 8

=item * $dbsys

database implmentation.  Defaults go Pg.  Only Pg is supported at this time: this may change.

=item * $dbname

database name.  Defaults to rcp.

=item * $host

host of the DB.  Defaults to localhost.

=item * $port

port of the DB.  Defaults to 5432, Pg's starting port.

=item * $user

username to access the DB.  Required!

=item * $pass

password to acces the DB.  Required!

=item * $options

various other options to pass in, such as AutoCommit or RaiseError.  Default provided.

=back

=back

This returns the database connection upon success.
L<Class::Singleton|Class::Singleton> ensures
there is only one connection per program.

=head2 get_db_system

Return the database system in use.

=cut

=head2 get_db_name

Return the database name we are using.

=head2 get_host

Return the host we are connecting to.

=head2 get_port

Return the port number we use for connecting to the DB.

=head1 INCOMPATIBILITIES

At this time, only PostGresQL databases are supported.
The author hopes to have support for more databases in the future.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SEE ALSO

perl(1), Class::Singleton, DBD::Pg

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Wolfman2000, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
