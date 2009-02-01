package Games::Framework::RCP::Database::Result::CombinedItem;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('combined_items');
__PACKAGE__->add_columns(
    id_combined_item => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the combined item.',
        extra => {unsigned => 1},
    },
    fkey_item => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the item in the items table.',
        extra => {unsigned => 1},
    },
    fkey_item_part_1 => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of original item number 1.',
        extra => {unsigned => 1},
    },
    fkey_item_part_2 => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of original item number 2.',
        extra => {unsigned => 1},
    },
);

__PACKAGE__->set_primary_key('id_combined_item');
__PACKAGE__->add_unique_constraint([qw/fkey_item_part_1 fkey_item_part_2/]);
__PACKAGE__->belongs_to(items => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item');
__PACKAGE__->belongs_to(orig_item_1 => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item_part_1');
__PACKAGE__->belongs_to(orig_item_2 => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item_part_2');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The list of item combinations.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CombinedItem - The list of item combinations.

=head1 VERSION

0.22

=head1 DESCRIPTION

The combined items table is a convenience table for
Game Masters.  As many like trying to combine two
or more various things together, this table allows
one to capture the various combinations that are tried.

For simplicity sake, this table assumes that combined
items only require two items to make a third.  If a
particular item requires three or more items, and
none of those can be pre-combined, then feel free
to modify the table above and allow NULL on the
extra columns.

=head1 DATABASE TABLE

The list of item combinations.

=head2 id_combined_item

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_item

This ID points to the Item table in a many to one mapping.

This is the item that results from combining the other two.

=head2 fkey_item_part_1

This ID points to the Item table in a many to one mapping.

This is the first item used to make fkey_item.

=head2 fkey_item

This ID points to the Item table in a many to one mapping.

This is the second item used to make fkey_item.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CombinedItem>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CombinedItem


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CombinedItem>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CombinedItem>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CombinedItem>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CombinedItem/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.