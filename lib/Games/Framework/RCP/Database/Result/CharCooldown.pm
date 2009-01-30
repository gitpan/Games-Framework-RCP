package Games::Framework::RCP::Database::Result::CharCooldown;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('char_cooldowns');
__PACKAGE__->add_columns(
    id_char_cooldown => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the character/move cooldown combination.',
        extra => {unsigned => 1},
    },
    fkey_character => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the character.',
        extra => {unsigned => 1},
    },
    fkey_move => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the move.',
        extra => {unsigned => 1},
    },
    cooldown => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'How long before the move can be moved',
    },
);

__PACKAGE__->set_primary_key('id_char_cooldown');
__PACKAGE__->add_unique_constraint([qw/fkey_character fkey_move/]);

__PACKAGE__->belongs_to(characters => 'Games::Framework::RCP::Database::Result::Character', 'fkey_character');

__PACKAGE__->belongs_to(moves => 'Games::Framework::RCP::Database::Result::Move', 'fkey_move');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('How long must characters cool down before using a move?');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CharCooldown

=head1 VERSION

0.21

=head1 DESCRIPTION

The char cooldown table houses various moves that have a cooldown
time associated with it.  Not every move allows one to spam it
repeatedly.  This table houses how long one must wait before
using that move again.

=head1 DATABASE TABLE

How long must characters cool down before using a move?

=head2 id_character_move

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_character

This ID points to the Character table in a many to many mapping.
Many moves could be in cooldown mode for a character.

=head2 fkey_move

This ID points to the Move table in a many to many mapping.
Many characters could be in cooldown mode for a move.

=head2 cooldown

This is how long until a move can be used again by a particular
character.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CharCooldown>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CharCooldown


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CharCooldown>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CharCooldown>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CharCooldown>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CharCooldown/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.