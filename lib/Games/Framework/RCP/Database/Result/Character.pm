package Games::Framework::RCP::Database::Result::Character;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('characters');
__PACKAGE__->add_columns(
    id_character => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the character.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 64,
        is_nullable => 0,
        comments => 'Name of the character.',
    },
    fkey_color => {
        data_type => 'integer',
        is_nullable => 1,
        comments => 'ID of the color set.',
        extra => {unsigned => 1},
    },
    is_male => {
        data_type => 'boolean',
        default_value => 'true',
        is_nullable => 1,
        comments => 'Gender of the character.  NULL = unknown.',
    },
    is_good => {
        data_type => 'boolean',
        default_value => 'true',
        is_nullable => 1,
        comments => 'Is this character good or evil?  NULL = neutral.',
    },
    is_lawful => {
        data_type => 'boolean',
        default_value => 'true',
        is_nullable => 1,
        comments => 'Is this character lawful or chaotic?  NULL = neutral.',
    }
);

__PACKAGE__->utf8_columns(qw/name/);
__PACKAGE__->set_primary_key('id_character');
__PACKAGE__->add_unique_constraint(['name']);

__PACKAGE__->has_one(callscript => 'Games::Framework::RCP::Database::Result::Callscript', 'fkey_character');

__PACKAGE__->has_one(player_char => 'Games::Framework::RCP::Database::Result::PlayerChar', 'fkey_character');

__PACKAGE__->has_one(combatant => 'Games::Framework::RCP::Database::Result::Combatant', 'fkey_character');

__PACKAGE__->belongs_to(color => 'Games::Framework::RCP::Database::Result::Color', 'fkey_color');

__PACKAGE__->has_many(character_moves => 'Games::Framework::RCP::Database::Result::CharacterMove', 'fkey_character');

__PACKAGE__->has_many(char_cooldowns => 'Games::Framework::RCP::Database::Result::CharCooldown', 'fkey_character');
__PACKAGE__->many_to_many(moves => 'char_cooldowns', 'characters');

__PACKAGE__->has_many(character_inventories => 'Games::Framework::RCP::Database::Result::CharacterInventory', 'fkey_character');
__PACKAGE__->many_to_many(items => 'character_inventories', 'characters');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every single character involved in this game one way or another.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Character

=head1 VERSION

0.21

=head1 DESCRIPTION

The characters table contains the list of every single character
that was involved with the game at once point or another.  It
is to house PCs and NPCs of various groupings.

=head1 DATABASE TABLE

Every single character involved in this game one way or another.

=head2 id_character

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

The name of the character.  32 characters of room for spelling,
but everyone MUST be unique.

=head2 fkey_color

This is an optional color code assignment for the character,
using the Color table.

=head2 is_male

This is a boolean that determines if the character is
male or female.  A NULL option indicates ambiguity,
unknown, or some other anomoly.

=head2 is_good

This is a boolean that determines if the character is
generally good or evil.  A NULL option indicates no
preference, or unknown.

=head2 is_lawful

This is a boolean that determines if the character 
upholds order or chaos.  A NULL option means
indifference.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Character>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Character


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Character>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Character>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Character>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Character/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.