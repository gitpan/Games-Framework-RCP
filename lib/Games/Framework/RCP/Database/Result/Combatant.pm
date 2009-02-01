package Games::Framework::RCP::Database::Result::Combatant;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('combatants');
__PACKAGE__->add_columns(
    id_combatant => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the combatant.',
        extra => {unsigned => 1},
    },
    join_time => {
        data_type => 'datetime',
        is_nullable => 0,
        default_value => 'now()',
        comments => 'Time the combatant joined.',
    },
    fkey_character => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the character.',
        extra => {unsigned => 1},
    },
    fkey_class => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the primary class.',
        extra => {unsigned => 1},
    },
    starting_job => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the class the combatant joined as.',
        extra => {unsigned => 1},
    },
    secondary => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 1,
        comments => 'The secondary class a fighter may bring.',
    },
    support => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 1,
        comments => 'A support skill a fighter may bring.',
    },
    reaction => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 1,
        comments => 'A reaction skill a fighter may bring.',
    },
    display_name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'The current name of the fighter.  Can be renamed mid-fight.',
    },
    hp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'HP',
    },
    mp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'MP',
    },
    pp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'PP',
    },
    max_hp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Max HP.',
    },
    max_mp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Max MP.',
    },
    max_pp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Max PP',
    },
    ct => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Charge Time.  Unit of measurement to see who moves.',
    },
    spd => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Speed',
    },
    patk => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Attack',
    },
    matk => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Attack',
    },
    pdef => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Defense',
    },
    mdef => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Defense',
    },
    pacc => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Accuracy',
    },
    macc => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Accuracy',
    },
    pevd => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Evade',
    },
    mevd => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Evade',
    },
);

__PACKAGE__->utf8_columns(qw/secondary support reaction display_name/);
__PACKAGE__->set_primary_key('id_combatant');
__PACKAGE__->add_unique_constraint([qw(fkey_character)]);

__PACKAGE__->belongs_to(character => 'Games::Framework::RCP::Database::Result::Character', 'fkey_character');

__PACKAGE__->belongs_to(class => 'Games::Framework::RCP::Database::Result::Class', 'fkey_class');

__PACKAGE__->belongs_to(class => 'Games::Framework::RCP::Database::Result::Class', 'starting_job');

__PACKAGE__->has_many(combatant_inventories => 'Games::Framework::RCP::Database::Result::CombatantInventory', 'fkey_combatant');
__PACKAGE__->many_to_many(items => 'combatant_inventories', 'combatants');

__PACKAGE__->has_many(combatants => 'Games::Framework::RCP::Database::Result::CombatantCurrency', 'fkey_combatant');
__PACKAGE__->many_to_many(currency => 'combatants', 'currency');

__PACKAGE__->has_many(combatant_equip_histories => 'Games::Framework::RCP::Database::Result::CombatantEquipHistory', 'fkey_combatant');
__PACKAGE__->many_to_many(equip_histories => 'combatant_equip_histories', 'items');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The list of everyone that is fighting currently.');
}

1;

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Combatant - The list of everyone that is fighting currently.

=head1 VERSION

0.22

=head1 DESCRIPTION

The combatants table contains who is currently in
the battle.  Each combatant plays as a job, and
may also take a secondary skillset, a support
skill, and/or a reaction skill.

Many of you may have noticed that this table includes
columns from the
L<Class|Games::Framework::RCP::Database::Result::Class> table.
While I could have chosen to just have a straight foreign key
to the class table and be done with it, that wouldn't allow
for actual stat changes during the fight.  While it may seem
like repeating data, it almost never stays constant.

=head1 DATABASE TABLE

The list of everyone that is fighting currently.

=head2 id_combatant

This is the primary key of the table,
using the traditional auto incrementing.

=head2 join_time

The time that the combatant entered the battle.  Used
as a backup method of sorting fighters.

=head2 fkey_character

This ID points to the Character table with a one to one mapping.
Duplicate characters are not allowed (in this version).

=head2 fkey_class

This ID points to the Class table with a many to one mapping.
The same class can be used by multiple people.
At times, this is encouraged.

For Game Master purposes, this represents the current primary
class the combatant is playing as.

=head2 starting_job

This is the same as fkey_class above, with the only difference
being that a record of what class a fighter joined as originally
is always stored, and should not be changed unless the fighter
is forcefully removed from battle.

=head2 secondary

This accepts 32 characters to represent a job class skillset
that a combatant is bringing.  It accepts a varchar instead
of a foreign key to allow combatants to have a little creative
freedom.

=head2 support

See secondary above, only it allows for a support move.

=head2 reaction

See secondary above, only it allows for a reaction move.

=head2 display_name

This accepts 32 characters to allow the Character to
be called something else as the battle requires.  Note
that this is NOT unique: if a Game Master wanted,
everyone could be "called" the same name.

=head2 hp

This is the combatant's health.

=head2 mp

This is the combatant's magic power.

=head2 pp

This is the combatant's physical power.

=head2 max_hp

This is the combatant's max health.

=head2 max_mp

This is the combatant's max magic power.

=head2 max_pp

This is the combatant's max physical power.

=head2 ct

This is the combatant's charge time.

=head2 spd

This is the combatant's speed.

=head2 patk

This is the combatant's physical attack.

=head2 matk

This is the combatant's magical attack.

=head2 pdef

This is the combatant's physical defense.

=head2 mdef

This is the combatant's magical defense.

=head2 pacc

This is the combatant's physical accuracy.

=head2 macc

This is the combatant's magical accuracy.

=head2 pevd

This is the combatant's physical evade.

=head2 mevd

This is the combatant's magical evade.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Combatant>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Combatant


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Combatant>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Combatant>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Combatant>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Combatant/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.