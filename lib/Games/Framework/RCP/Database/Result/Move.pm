package Games::Framework::RCP::Database::Result::Move;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('moves');
__PACKAGE__->add_columns(
    id_move => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the move.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 64,
        is_nullable => 0,
        comments => 'Name of the move.',
    },
    fkey_move_type => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the move type.',
        extra => {unsigned => 1},
    },
    power => {
        data_type => 'varchar',
        size => 8,
        is_nullable => 1,
        comments => 'Power of the move.  Not all have power.',
    },
    warmup => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => undef,
        comments => 'How long before the move can be used to start?',
    },
    cooldown => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => undef,
        comments => 'How long before the move can be used again?',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 0,
        comments => 'Description of the move.',
    },
);

__PACKAGE__->utf8_columns(qw/name description power/);
__PACKAGE__->set_primary_key('id_move');
__PACKAGE__->add_unique_constraint(['name']);

__PACKAGE__->belongs_to(move_types => 'Games::Framework::RCP::Database::Result::MoveType', 'fkey_move_type');

__PACKAGE__->has_many(moves_with_flags => 'Games::Framework::RCP::Database::Result::MoveWithFlag', 'fkey_move');
__PACKAGE__->many_to_many(move_flags => 'moves_with_flags', 'moves');

__PACKAGE__->has_many(moves_with_costs => 'Games::Framework::RCP::Database::Result::MoveWithCost', 'fkey_move');
__PACKAGE__->many_to_many(move_costs => 'moves_with_costs', 'moves');

__PACKAGE__->has_many(class_moves => 'Games::Framework::RCP::Database::Result::ClassMove', 'fkey_move');
__PACKAGE__->many_to_many(classes => 'class_moves', 'moves');

__PACKAGE__->has_many(char_cooldowns => 'Games::Framework::RCP::Database::Result::CharCooldown', 'fkey_move');
__PACKAGE__->many_to_many(characters => 'char_cooldowns', 'moves');

__PACKAGE__->has_many(character_moves => 'Games::Framework::RCP::Database::Result::CharacterMove', 'fkey_move');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every single move available in the game.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Move

=head1 VERSION

0.21

=head1 DESCRIPTION

The moves table contains every single move that combatants and
others can use during the battle.

=head1 DATABASE TABLE

Every single move available in the game.

=head2 id_move

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 64 characters to identify the move name.
All move names are to be unique.

=head2 fkey_move_type

This ID points to the Move Types table in a one to one mapping.
Each move has a specific way it can be used.

=head2 power

This accepts 8 characters to identify the power of the move.
It is a varchar versus an integer to allow for variable power
ratings.  Not all moves use power: this is mainly for moves
that do not attack/hurt anyone.

=head2 warmup

This indicates how long one must wait from declaring the
move to actually using it.

=over 4

=item * 0 or NULL: immediately use.

=item * greater than 0: charge up/telegraph the move.

=item * less than 0: time travel issues.

=back

=head2 cooldown

This indicates how long after the move is used a combatant
must wait before using the same move again.

=over 4

=item * 0 or NULL: no cooldown: can use again next turn.

=item * greater than 0: must wait a number of ticks before using.

=item * less than 0: time travel issues.

=back

=head2 description

This accepts 256 characters to add some flavortext to the
move.  Such text can be humurous, or it could
indicate what the move does when used.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Move>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Move


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Move>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Move>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Move>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Move/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.