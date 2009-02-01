package Games::Framework::RCP::Database::Result::Item;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('items');
__PACKAGE__->add_columns(
    id_item => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the item.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 64,
        is_nullable => 0,
        comments => 'Name of the item.',
    },
    ammo => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => 1,
        comments => 'How many uses of the item are available?',
    },
    fkey_item_usage => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the item usage.',
        extra => {unsigned => 1},
    },
    fkey_item_category => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => undef,
        comments => 'ID of the item category.',
        extra => {unsigned => 1},
    },
    power => {
        data_type => 'varchar',
        size => 8,
        is_nullable => 1,
        comments => 'Power of the item.  Not all have power.',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 0,
        comments => 'Description of the item.',
    },
    cooldown => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => undef,
        comments => 'How long one must wait before using the item again.',
    },
);

__PACKAGE__->utf8_columns(qw/name description power/);
__PACKAGE__->set_primary_key('id_item');
__PACKAGE__->add_unique_constraint(['name']);

__PACKAGE__->belongs_to(item_usage => 'Games::Framework::RCP::Database::Result::ItemUsage', 'fkey_item_usage');

__PACKAGE__->belongs_to(item_category => 'Games::Framework::RCP::Database::Result::ItemCategory', 'fkey_item_category');

__PACKAGE__->has_many(combined_items => 'Games::Framework::RCP::Database::Result::CombinedItem', 'fkey_item');
__PACKAGE__->has_many(original_item_1 => 'Games::Framework::RCP::Database::Result::CombinedItem', 'fkey_item_part_1');
__PACKAGE__->has_many(original_item_2 => 'Games::Framework::RCP::Database::Result::CombinedItem', 'fkey_item_part_2');

__PACKAGE__->has_many(items_with_stats => 'Games::Framework::RCP::Database::Result::ItemWithStat', 'fkey_item');
__PACKAGE__->many_to_many(item_stats => 'items_with_stats', 'items');

__PACKAGE__->has_many(items_with_statuses => 'Games::Framework::RCP::Database::Result::ItemWithStatus', 'fkey_item');
__PACKAGE__->many_to_many(status_effects => 'items_with_statuses', 'items');

__PACKAGE__->has_many(character_inventories => 'Games::Framework::RCP::Database::Result::CharacterInventory', 'fkey_item');
__PACKAGE__->many_to_many(characters => 'character_inventories', 'items');

__PACKAGE__->has_many(combatant_inventories => 'Games::Framework::RCP::Database::Result::CombatantInventory', 'fkey_item');
__PACKAGE__->many_to_many(combatants => 'combatant_inventories', 'items');

__PACKAGE__->has_many(combatant_equip_histories => 'Games::Framework::RCP::Database::Result::CombatantEquipHistory', 'fkey_item');
__PACKAGE__->many_to_many(equip_histories => 'combatant_equip_histories', 'combatants');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every single item available in the game.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Item - Every single item available in the game.

=head1 VERSION

0.22

=head1 DESCRIPTION

The items table contains every item that a Game Master
can use.  They can do anything from recovering health
to protecting an ally to sending anyone away, or
anything else.

=head1 DATABASE TABLE

Every single item available in the game.

=head2 id_item

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 64 characters to name the item.
All items must have a unique name.

=head2 ammo

This integer shows how many uses of the item are
generally available by default.  Usually, one use
is all one gets.

=head2 fkey_item_usage

This ID points to the Item Usages table in a one to one mapping.
Each item can only be used in a specific way.

This field may be abstracted out in the future.

=head2 fkey_item_category

This ID points to the Item Categories table in a one to one mapping.
Item can be categorized in various ways.

This field may be abstracted out in the future.

=head2 power

This indicates the item's power.

This field may be removed in the future.

=head2 description

This accepts 256 characters to add some flavortext to the
item.  Such text can be humurous, or it could
indicate what the item will do when used.

=head2 cooldown

Some items have a cooldown period: once used, another
copy of the same item can't be used for this many
ticks.  A value of 0 or NULL means no cooldown.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Item>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Item


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Item>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Item>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Item>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Item/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.