package Games::Framework::RCP::Database::Result::PlayerChar;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('player_chars');
__PACKAGE__->add_columns(
    id_player_char => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the playable character.',
        extra => {unsigned => 1},
    },
    fkey_character => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the actual character.',
        extra => {unsigned => 1},
    }
);
__PACKAGE__->set_primary_key('id_player_char');
__PACKAGE__->belongs_to(character => 'Games::Framework::RCP::Database::Result::Character', 'fkey_character');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The list of every character with a real player behind the screen.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::PlayerChar - The list of every character with a real player behind the screen.

=head1 VERSION

0.22

=head1 DESCRIPTION

The player chars table is a convenience table that allows
a Game Master to see which of the characters are directly
controlled by the players.  This can often be useful for
the purposes of giving awards.

=head1 DATABASE TABLE

The list of every character with a real player behind the screen.

=head2 id_player_char

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_character

This ID points to the Character table in a one to one mapping.
Not all characters are playable by a player.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-PlayerChar>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::PlayerChar


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-PlayerChar>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-PlayerChar>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-PlayerChar>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-PlayerChar/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.