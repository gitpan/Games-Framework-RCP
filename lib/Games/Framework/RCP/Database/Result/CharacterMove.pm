package Games::Framework::RCP::Database::Result::CharacterMove;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('character_moves');
__PACKAGE__->add_columns(
    id_character_move => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the character move recorded.',
        extra => {unsigned => 1},
    },
    fkey_character => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the character.',
        extra => {unsigned => 1},
    },
    fkey_class => {
        data_type => 'integer',
        is_nullable => 1,
        comments => 'ID of the class the move belongs to.',
        extra => {unsigned => 1},
    },
    fkey_move => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the move.',
        extra => {unsigned => 1},
    },
);

__PACKAGE__->set_primary_key('id_character_move');
__PACKAGE__->add_unique_constraint([qw/fkey_character fkey_class fkey_move/]);

__PACKAGE__->belongs_to(characters => 'Games::Framework::RCP::Database::Result::Character', 'fkey_character');

__PACKAGE__->belongs_to(classes => 'Games::Framework::RCP::Database::Result::Class', 'fkey_class');

__PACKAGE__->belongs_to(moves => 'Games::Framework::RCP::Database::Result::Move', 'fkey_move');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('All of the moves that every character knows.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CharacterMove

=head1 VERSION

0.21

=head1 DESCRIPTION

The character moves table is a rare "many to many to many" table
in the database world.  Each playable character can have many
moves in many different classes, with some players having the
same move in two or more different classes.

=head1 DATABASE TABLE

All of the moves that every character knows.

=head2 id_character_move

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_character

This ID points to the Character table in a many to many mapping.

=head2 fkey_class

This ID points to the Class table in a many to many mapping.

=head2 fkey_move

This ID points to the Move table in a many to many mapping.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CharacterMove>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CharacterMove


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CharacterMove>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CharacterMove>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CharacterMove>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CharacterMove/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.