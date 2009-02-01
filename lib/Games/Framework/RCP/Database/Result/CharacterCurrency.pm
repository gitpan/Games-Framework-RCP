package Games::Framework::RCP::Database::Result::CharacterCurrency;

use strict;
use warnings;
use utf8;

our $VERSION = '0.20';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('character_currency');
__PACKAGE__->add_columns(
    id_character_inventory => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the character / currency combination.',
        extra => {unsigned => 1},
    },
    fkey_character => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the character.',
        extra => {unsigned => 1},
    },
    fkey_currency => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the currency.',
        extra => {unsigned => 1},
    },
    quantity => {
        data_type => 'numeric',
        size => [12,4],
        is_nullable => 1,
        default_value => 0,
        comments => 'How much of this currency does the character have in storage?',
    },
);

__PACKAGE__->set_primary_key('id_character_inventory');

__PACKAGE__->belongs_to(currency => 'Games::Framework::RCP::Database::Result::Currency', 'fkey_currency');

__PACKAGE__->belongs_to(characters => 'Games::Framework::RCP::Database::Result::Character', 'fkey_character');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every currency a character has in storage.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CharacterCurrency - Every currency a character has in storage.

=head1 VERSION

0.21

=head1 DESCRIPTION

The character currency table shows all of the money characters
have in storage in various forms.  Some Game Masters may also
want to use this as an "infinite storage locker" for fighters
to store money not brought to battle.  Others may want to use
this instead of CombatantCurrency to deal with currency found
in battle.  The uses are vast.

=head1 DATABASE TABLE

Every item a character has in storage.

=head2 id_character_currency

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_character

This ID points to the Character table in a many to one mapping.
Many currency can belong to a character.

=head2 fkey_currency

This ID points to the Currency table in a many to one mapping.
Many characters can have the same currency.

=head2 quantity

This real number shows how much of the given currency is available.
In general, once this hits zero, the currency should be removed
from the table.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CharacterCurrency>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CharacterCurrency


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CharacterCurrency>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CharacterCurrency>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CharacterCurrency>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CharacterCurrency/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
