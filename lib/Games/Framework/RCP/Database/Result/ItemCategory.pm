package Games::Framework::RCP::Database::Result::ItemCategory;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('item_categories');
__PACKAGE__->add_columns(
    id_item_category => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the item category.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => '32',
        is_nullable => 0,
        comments => 'Name of the item category.',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 0,
        comments => 'Description of the item category.',
    },
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_item_category');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->might_have(class => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item_category', {cascade_delete => 0});

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('A list of the various item categories.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ItemCategory - A list of the various item categories.

=head1 VERSION

0.22

=head1 DESCRIPTION

The item categories table allows Game Masters to group
items together into similar...well, categories.  This 
could be useful if a particular set of items must be
drawn from.

=head1 DATABASE TABLE

A list of the various item categories.

=head2 id_item_category

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 32 characters to name an item category.
This is UNIQUE.

=head2 description

This accepts 256 characters to add some flavortext to the
item category.  Such text can be humurous, or it could
indicate what the items inside may be.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ItemCategory>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ItemCategory


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ItemCategory>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ItemCategory>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ItemCategory>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ItemCategory/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.