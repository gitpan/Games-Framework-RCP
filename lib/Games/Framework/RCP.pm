# $Revision: 0.01_02 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP.pm $

package Games::Framework::RCP;

use 5.010;

use warnings;
use strict;

our $VERSION = '0.01_02';

1;

__END__

=head1 DISCLAIMER

This software is currently under development.  It is not done.
While it will not be done quickly, contributions can help
make things go faster.  Please contribute if you can.

=head1 NAME

Games::Framework::RCP - Final Fantasy Tactics based battle system.

=head1 DEPENDENCIES

This module is merely a documentation module.  To get the best
use out of it, download all of the other Games::Framework::RCP
modules as well.  For best functionality, make sure to also
have the following modules installed on your system.

=over 4

=item *

Perl version 5.10 or higher

=item *

L<DBD::Pg|DBD::Pg>

=item *

L<Class::Singleton|Class::Singleton>

=back

=head1 VERSION

Version 0.01_02

=head1 SYNOPSIS

This is coming later, when more is developed.

=head1 DESCRIPTION

I am making a (pretty poor) assumption that most people that read this
have heard of the game Final Fantasy.  The long running role playing
game series has spun off into its own Tactics based series, with
a huge success.  This module is one such recreation of the majority
of the core battle functionality of the Tactics system, while adding
other options that Game Masters may want to use for variety.

To view the inspiration for this, please check
L<the acknowledgements section|/"ACKNOWLEDGEMENTS">.

=head1 CONFIGURATION AND ENVIRONMENT

The only requirements for the environment are that PostGresQL is installed.
In the future, other database systems may be supported.

=head1 INSTALL

Due to how CPAN and CPANPLUS work, installing
this module and its dependencies do not install the database that
drives this system.  Therefore, the following instructions are given
to ensure that everything gets installed.

=over 4

=item 1

Download the tar.gz file.

=item 2

Extract the tar.gz file.  In the command line, C<tar xvf Games-Framework-RCP.tar.gz> will work.

=item 3

Change to the extracted directory.

=item 4

Type in the command line: C<perl Makefile.PL>.

=item 5

Load the pg.sql file from the scripts directory into your PostGresQL system.

=item 6

Set the environment variables DB_TEST_USERNAME and DB_TEST_PASSWORD with
your preferred username and password.

=item 7

Type in the command line: C<make>.

=item 8

Type in the command line: C<make test>.  If the tests do not pass, let me know.
My information is at L<the author section|/"AUTHOR">.

=item 9

Type in the command line: C<sudo make install>.

=item 10

Create/use a L</"driver program"> to interface with these modules.

=item 11

Have fun!

=back

=head1 MODULES

The modules included are as follows:

=over 4

=item * L<Games::Framework::RCP::Battle|Games::Framework::RCP::Battle>

A documentation class that explains the tables in the Battle schema/section.

=item * L<Games::Framework::RCP::Data|Games::Framework::RCP::Data>

A documentation class that explains the tables in the Data schema/section.

=over 8

=item * L<Games::Framework::RCP::Data::Classes|Games::Framework::RCP::Data::Classes>

Functions avaiable for interacting with the data.classes table.

=back

=item * L<Games::Framework::RCP::Database|Games::Framework::RCP::Database>

The singleton class that allows for connecting to the database.  Currently PostGresQL only.

=item * L<Games::Framework::RCP::Exceptions|Games::Framework::RCP::Exceptions>

A (mostly) documentation class that explains the exceptions in use.

=item * L<Games::Framework::RCP::Utilities|Games::Framework::RCP::Utilities>

A documentation class that explains the tables in the Utilities schema/section.

=over 8

=item * L<Games::Framework::RCP::Utilities::Colors|Games::Framework::RCP::Utilities::Colors>

Functions available for interacting with the utilities.colors table.

=item * L<Games::Framework::RCP::Utilities::Vars_Bool|Games::Framework::RCP::Utilities::Vars_Bool>

Functions available for interacting with the utilities.vars_bool table.

=item * L<Games::Framework::RCP::Utilities::Vars_Ints|Games::Framework::RCP::Utilities::Vars_Ints>

Functions available for interacting with the utilities.vars_ints table.

=item * L<Games::Framework::RCP::Utilities::Vars_Real|Games::Framework::RCP::Utilities::Vars_Real>

Functions available for interacting with the utilities.vars_real table.

=back

=back

=head1 DRIVER PROGRAM

At this time, there is no "driver" program file that is in place to
interface with these modules.  In time, I will release one such driver
program for X-Chat.

If anyone wants to contribute their own setups (say, for other IRC clients
or something else exotic), let me know and I will credit you properly.

=head1 SUBROUTINES/METHODS

There are no subroutines in this module.

=head1 INCOMPATIBILITIES

There are no known incompatibilities in this module.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP/>

=back


=head1 ACKNOWLEDGEMENTS

This author acknowledges the previous authors of such battle systems
that were used for the mIRC program.  The latest author of such a system,
Kafei, is currently hosting his own using said mIRC program.  More info
can be found here: http://www.roleplayx.net/wiki/index.php/RoleplayX

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.