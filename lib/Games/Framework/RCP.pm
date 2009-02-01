package Games::Framework::RCP;

our $VERSION = '0.03_01';

1;

__END__

=head1 DISCLAIMER

This software is currently under development.  It is not done.
While it will not be done quickly, contributions can help
make things go faster.  Please contribute if you can.

=head1 NAME

Games::Framework::RCP - Generic video game tactics based battle system.

=head1 DEPENDENCIES

=over 4

=item *

L<DBIx::Class|DBIx::Class>

=item *

L<Exceptions::Class|Exceptions::Class>

=item *

L<SQL::Translator|SQL::Translator>

=item *

L<Sub::Exporter|Sub::Exporter>

=back

=head1 VERSION

0.03_01

=head1 SYNOPSIS

After setting up a database name:

 use Games::Framework::RCP::Setup qw/:all/;
 my $schema = login( "DBIx connection parameters" );
 
 $schema->deploy({add_drop_table => 1}); # Have to load the data.
 
 load_defaults(); # optional: can provide basic data.
 
 # At this point, have a ball.

=head1 DESCRIPTION

I am making a (pretty poor) assumption that most people that read this
have played at least one tactics/strategy game, such as Fire Emblem,
Final Fantasy Tactics, or Disgaea.  This module is one such recreation
of the majority of the core battle functionality of the Tactics system,
while adding other options that Game Masters may want to use for variety.

To view the inspiration for this, and why it's called 'RCP', please check
L<the acknowledgements section|/"ACKNOWLEDGEMENTS">.

=head1 CONFIGURATION AND ENVIRONMENT

This module requires a database to be installed.  Support for
MySQL, PostGresQL, and SQLite is out of the box.  Other systems
may require extra work.

=head1 INSTALL

Either CPAN or CPANPLUS can be used.  For those that prefer
manual compilation:

 perl Makefile.PL
 make
 make test
 make install

You may require root priviledges to C<make install>.

=head1 DRIVER PROGRAM

At this time, there is no "driver" program file that is in place to
interface with these modules.  In time, I will release one such driver
program for X-Chat.

If anyone wants to contribute their own setups (say, for other IRC clients
or something else exotic), let me know and I will credit you properly.

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

This author also acknowledges the CPAN Testers that love to try installing
development modules.  Among the things found by them:

=over 4

=item *

Perl 5.8 will work fine for this module.  There should be no exclusive
5.10 code.

=item *

SQL::Translator does not come with DBIx::Class.  That requirement
is now explicit.

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.