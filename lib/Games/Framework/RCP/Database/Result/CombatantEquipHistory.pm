package Games::Framework::RCP::Database::Result::CombatantEquipHistory;

use strict;
use warnings;
use utf8;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('combatant_equip_history');
__PACKAGE__->add_columns(
    id_combatant_equip_history => {
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
    equip_time => {
        data_type => 'datetime',
        is_nullable => 0,
        default_value => 'now()',
        comments => 'Time the item was used ont he combatant.',
    },
    fight_length => {
        data_type => 'integer',
        is_nullable => 1,
        comments => 'How far in the battle when the item was equipped.',
    },
);

__PACKAGE__->set_primary_key('id_combatant_equip_history');

__PACKAGE__->add_unique_constraint([qw/fkey_combatant fkey_item equip_time/]);

__PACKAGE__->belongs_to(items => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item');

__PACKAGE__->belongs_to(combatants => 'Games::Framework::RCP::Database::Result::Combatant', 'fkey_combatant');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('A history of every item equipped in the battle.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CombatantEquipHistory - A history of every item equipped in the battle.

=head1 VERSION

0.22

=head1 DESCRIPTION

The combatant equip history table shows all of the items that
every fighter has equipped over the course of the current battle.
This is mainly a convenience table for Game Masters for the purposes
of bookkeeping.  It can also be used to look back at history and
correct a mistake.

=head1 DATABASE TABLE

A history of every item equipped in the battle.

=head2 id_combatant_equip_history

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_combatant

This ID points to the Combatant table in a many to one mapping.
Many items can belong to a combatant.

=head2 fkey_item

This ID points to the Item table in a many to one mapping.
Many combatants can have the same item.

=head2 equip_time

This is the time that the chosen item was equipped by the
chosen combatant.  This is a guaranteed of record keeping.

=head2 fight_length

This optional column is how long since the start of the battle
that the item was used on the combatant.  Game Masters that use
this column can more likely pinpoint stat boosts, status changes,
etc from any point in time.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CombatantEquipHistory>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CombatantEquipHistory


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CombatantEquipHistory>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CombatantEquipHistory>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CombatantEquipHistory>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CombatantEquipHistory/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
