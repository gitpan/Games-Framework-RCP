package Games::Framework::RCP::Database;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class::Schema/;

__PACKAGE__->load_namespaces();

1;

__END__

=head1 NAME

Games::Framework::RCP::Database - DBIx::Class setup file

=head1 VERSION

0.22

=head1 SYNOPSIS

 use Games::Framework::RCP::Setup qw/login load_defaults/;
 my $schema = login($data_source, $username, $password, $options, $on_connect);
 load_defaults();
 
 # Do whatever you want with the schema.

=head1 DESCRIPTION

This module is responsible for loading all of the database tables.
Once loaded, Game Masters can do whatever they want.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

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

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.