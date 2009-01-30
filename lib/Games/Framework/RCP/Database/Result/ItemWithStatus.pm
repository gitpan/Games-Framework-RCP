package Games::Framework::RCP::Database::Result::ItemWithStatus;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('items_with_statuses');
__PACKAGE__->add_columns(
    id_item_with_status => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the item/status effect combination.',
        extra => {unsigned => 1},
    },
    fkey_item => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the item.',
        extra => {unsigned => 1},
    },
    fkey_status_effect => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the status effect.',
        extra => {unsigned => 1},
    },
    'length' => {
        data_type => 'numeric',
        size => [12,4],
        is_nullable => 0,
        default_value => 31,
        comments => 'The length of the status effect given by the item.',
    },
);

__PACKAGE__->set_primary_key('id_item_with_status');
__PACKAGE__->add_unique_constraint(['fkey_item', 'fkey_status_effect']);

__PACKAGE__->belongs_to(items => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item');
__PACKAGE__->belongs_to(status_effects => 'Games::Framework::RCP::Database::Result::StatusEffect', 'fkey_status_effect');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every item that gives a status effect upon using.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ItemWithStatus

=head1 VERSION

0.21

=head1 DESCRIPTION

The items with statuses table shows what status effects are
given to the combatant when an item is used on him or her.  For
the most part, these are identified clearly.  Are they worth
the risk?

=head1 DATABASE TABLE

Every item that gives a status effect upon using.

=head2 id_item_with_status

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_item

This ID points to the Item table in a many to one mapping.
An item can give more than one status effect.

=head2 fkey_status_effect

This ID points to the Status Effects table in a many to one mapping.
A status effect can be granted by more than one item.

=head2 length

This indicates how long the status effect lasts once the item
is used up.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ItemWithStatus>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ItemWithStatus


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ItemWithStatus>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ItemWithStatus>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ItemWithStatus>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ItemWithStatus/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.