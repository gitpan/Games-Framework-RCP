package Games::Framework::RCP::Database::Result::CombatantCurrency;

use strict;
use warnings;
use utf8;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('combatant_currency');
__PACKAGE__->add_columns(
    id_combatant_inventory => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the combatant / currency combination.',
        extra => {unsigned => 1},
    },
    fkey_combatant => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the combatant.',
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
        comments => 'How much of this currency does the combatant have in battle?',
    },
);

__PACKAGE__->set_primary_key('id_combatant_inventory');

__PACKAGE__->belongs_to(currency => 'Games::Framework::RCP::Database::Result::Currency', 'fkey_currency');

__PACKAGE__->belongs_to(combatants => 'Games::Framework::RCP::Database::Result::Combatant', 'fkey_combatant');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every currency a combatant has in battle.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CombatantCurrency - Every currency a combatant has in battle.

=head1 VERSION

0.22

=head1 DESCRIPTION

The combatant currency table contains all of the currency that
that the characters have in their in battle inventory.
This is separate from CharacterCurrency, which is generally
meant for currency held outside of battle.  However, some Game Masters
may like using CharacterCurrency instead.  The choice is theirs.

=head1 DATABASE TABLE

Every currency a combatant has in battle.

=head2 id_combatant_currency

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_combatant

This ID points to the Combatant table in a many to one mapping.
Many currency can belong to a combatant.

=head2 fkey_currency

This ID points to the Currency table in a many to one mapping.
Many combatants can have the same currency.

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
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CombatantCurrency>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CombatantCurrency


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CombatantCurrency>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CombatantCurrency>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CombatantCurrency>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CombatantCurrency/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
