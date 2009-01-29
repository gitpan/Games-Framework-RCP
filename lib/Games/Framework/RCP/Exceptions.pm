package Games::Framework::RCP::Exceptions;

use warnings;
use strict;
use utf8;

our $VERSION = '0.05';

use Exception::Class (
    'Private' => {
        description => 'Illegal access of private subroutine.',
    },
    'DB_Gen_Exception' => {
        description => 'Database related issues.'
    },
    'DB_Invalid_Type' => {
        isa         => 'DB_Gen_Exception',
        description => 'Violations of database types.'
    },
    'DB_Non_Existant' => {
        isa         => 'DB_Gen_Exception',
        description => 'Record does not exist.'
    },
    'DB_Non_Unique' => {
        isa         => 'DB_Gen_Exception',
        description => 'Violations of [uniq] or [pk].'
    },
    'DB_Missing_Params' => {
        isa         => 'DB_Gen_Exception',
        description => 'Not enough information for inserting data.'
    },
);

1;

__END__

=head1 DISCLAIMER

This software is currently under development.  It is not done.
While it will not be done quickly, contributions can help
make things go faster.  Please contribute if you can.

=head1 NAME

Games::Framework::RCP::Exceptions - List of the various exceptions.

=head1 VERSION

0.05

=head1 SYNOPSIS

To use the modules:

 use Games::Framework::RCP::Exceptions;
 # Find the right exception (in this case, DB_Gen_Exception)
 DB_Gen_Exception->throw( error => 'Your message here.' );

=head1 DESCRIPTION

This module houses all of the various exceptions that could be
encountered while running this program.  Each function in
the other (non documentation) modules is to return either
a simple true value or an actual context variable.  If
anything goes wrong in the subroutines, they are supposed
to throw the error and abandon work.

It is the work of a driver program to keep an eye out
for these exceptions and process them however said
program wishes.

=head1 SUBROUTINES/METHODS

There are no subroutines in this module.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 CONFIGURATION AND ENVIRONMENT

No configuration should be required.

=head1 DEPENDENCIES

The requirements for this module are as follows:

=over 4

=item * Perl 5.10 or higher

Some of the new syntax operators are used.

=item * L<Exception::Class|Exception::Class>

This powers the exceptions.

=back

=head1 INCOMPATIBILITIES

There are no known incompatibilities in this module.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Exceptions>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Exceptions


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Exceptions>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Exceptions>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Exceptions>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Exceptions/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
