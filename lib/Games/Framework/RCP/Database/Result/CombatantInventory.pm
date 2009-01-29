package Games::Framework::RCP::Database::Result::CombatantInventory;

use 5.010;

use strict;
use warnings;
use utf8;

our $VERSION = '0.20';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('combatant_inventory');
__PACKAGE__->add_columns(
    id_combatant_inventory => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the combatant / item combination.',
        extra => {unsigned => 1},
    },
    fkey_combatant => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the combatant.',
        extra => {unsigned => 1},
    },
    fkey_item => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the item.',
        extra => {unsigned => 1},
    },
    display_name => {
        data_type => 'varchar',
        size => 64,
        is_nullable => 1,
        default_value => undef,
        comments => 'Publically displayed name of the item.',
    },
    ammo => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => 1,
        comments => 'How much of this item does the combatant have in storage?',
    },
);

__PACKAGE__->utf8_columns(qw/display_name/);

__PACKAGE__->set_primary_key('id_combatant_inventory');

__PACKAGE__->belongs_to(items => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item');

__PACKAGE__->belongs_to(combatants => 'Games::Framework::RCP::Database::Result::Combatant', 'fkey_combatant');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every item a combatant has in battle.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CombatantInventory

=head1 VERSION

0.20

=head1 DESCRIPTION

The combatant inventory table contains all of the items that
that the characters have in their in battle inventory.
This is separate from CharacterInventory, which is generally
meant for items held outside of battle.  However, some Game Masters
may like using CharacterInventory instead.  The choice is theirs.

=head1 DATABASE TABLE

Every item a combatant has in battle.

=head2 id_combatant_inventory

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_combatant

This ID points to the Combatant table in a many to one mapping.
Many items can belong to a combatant.

=head2 fkey_item

This ID points to the Item table in a many to one mapping.
Many combatants can have the same item.

=head2 display_name

An alternate name can be provided for the item as the time
arises.  However, try to stick with the item ID whenever possible.

=head2 ammo

This integer shows how many uses of the item are available.
In general, once this hits zero, the item should be removed
from the table.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CombatantInventory>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CombatantInventory


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CombatantInventory>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CombatantInventory>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CombatantInventory>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CombatantInventory/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
