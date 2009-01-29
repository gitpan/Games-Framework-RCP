package Games::Framework::RCP::Database::Result::ClassKind;

use 5.010;

use strict;
use warnings;

our $VERSION = '0.02';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('class_kinds');
__PACKAGE__->add_columns(
    id_kind => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the class kind.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'What type of class is this? (generally meant for public)',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 0,
        comments => 'What type of class is this? (generally meant for private)',
    },
);

__PACKAGE__->utf8_columns(qw/description/);
__PACKAGE__->set_primary_key('id_kind');
__PACKAGE__->add_unique_constraint([qw/name/]);
__PACKAGE__->has_one(class => 'Games::Framework::RCP::Database::Result::Class', 'fkey_kind');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('A list of the various types of classes.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ClassKind

=head1 VERSION

0.20

=head1 DESCRIPTION

The class_kinds table contains the list of various class types.
A particular class type is playable by certain people.  In general,
players will not be able to play as boss classes, for instance.

=head1 DATABASE TABLE

A list of the various types of classes.

=head2 id_class_kind

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This is the name of the type of class.  This MUST be unique.

=head2 description

This accepts 256 characters to add some flavortext to the
class kind.  Such text can be humurous.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ClassKind>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ClassKind


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ClassKind>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ClassKind>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ClassKind>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ClassKind/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.