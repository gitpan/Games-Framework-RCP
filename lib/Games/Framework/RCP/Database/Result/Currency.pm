package Games::Framework::RCP::Database::Result::Currency;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('currency');
__PACKAGE__->add_columns(
    id_currency => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the currency.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'Name of the currency.',
    },
    fkey_color => {
        data_type => 'integer',
        is_nullable => 1,
        comments => 'ID of the color set.',
        extra => {unsigned => 1},
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 1,
        comments => 'Description of the currency.',
    },
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_currency');
__PACKAGE__->add_unique_constraint(['name']);

__PACKAGE__->has_many(currency => 'Games::Framework::RCP::Database::Result::CharacterCurrency', 'fkey_currency');
__PACKAGE__->many_to_many(characters => 'currency', 'character');

__PACKAGE__->has_many(currency => 'Games::Framework::RCP::Database::Result::CombatantCurrency', 'fkey_currency');
__PACKAGE__->many_to_many(combatants => 'currency', 'combatant');

__PACKAGE__->belongs_to(color => 'Games::Framework::RCP::Database::Result::Color', 'fkey_color');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The different currencies available.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Currency - The different currencies available.

=head1 VERSION

0.22

=head1 DESCRIPTION

The currency table has a list of all of the various currencies
available in the battle system.  Money can be used for many
things to the imaginative Game Master.  Some may allow multiple
currency to exist in their game as well.  This table allows
many different implementations.

=head1 DATABASE TABLE

The different currencies available.

=head2 id_move_type

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 32 characters to identify the name of the currency.
Needless to say, this is unique.

=head2 fkey_color

This ID points to the Color table in a one to one mapping.
Game Masters may want to color currencies to make it easier
to identify.

=head2 description

This accepts 256 characters to add some flavortext to the
currency.  Such text can be humurous, or it could
indicate how the currency is earned, traded, or spent.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Currency>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Currency


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Currency>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Currency>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Currency>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Currency/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.