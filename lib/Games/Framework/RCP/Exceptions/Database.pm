# $Revision: 0.02 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Exceptions/Database.pm $

package Games::Framework::RCP::Exceptions::Database;

use warnings;
use strict;
use utf8;

our $VERSION = '0.02';

1;

__END__

=head1 DISCLAIMER

This software is currently under development.  It is not done.
While it will not be done quickly, contributions can help
make things go faster.  Please contribute if you can.

=head1 NAME

Games::Framework::RCP::Exceptions::Database - Documentation module for Database exceptions.

=head1 VERSION

This is version 0.02 of the module.

=head1 SYNOPSIS

View L<the base Exceptions manpage|Games::Framework::RCP::Exceptions> for more information.

=head1 DESCRIPTION

This module focuses on the various Database related exceptions one
can experience.  Such exceptions include wrong variable types,
bad login information, and more.

It is recommended to only throw this particular exception if
no other error has been defined.

=head1 SUBROUTINES/METHODS

=head2 description

Return the simple description of the exception.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 CONFIGURATION AND ENVIRONMENT

No configuration should be required.

=head1 DEPENDENCIES

The requirements for this module are as follows:

=over 4

=item * Perl 5.10 or higher

Some of the new syntax operators are used.

=item * L<Games::Framework::RCP::Exceptions|Games::Framework::RCP::Exceptions>

The exceptions originate from there.

=item * L<Exception::Class|Exception::Class>

This powers the exceptions.

=back

=head1 INCOMPATIBILITIES

There are no known incompatibilities in this module.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Exceptions-Database>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Exceptions::Database


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Exceptions-Database>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Exceptions-Database>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Exceptions-Database>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Exceptions-Database/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
