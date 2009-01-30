package Games::Framework::RCP::Database::Result::CombatantStatus;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('combatant_status');
__PACKAGE__->add_columns(
    id_combatant_status => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the combatant status effect.',
        extra => {unsigned => 1},
    },
    fkey_combatant => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the combatant.',
        extra => {unsigned => 1},
    },
    fkey_status_effect => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the status effect.',
        extra => {unsigned => 1},
    },
    'length' => {
        data_type => 'numeric',
        size => [12,4],
        default_value => 31,
        is_nullable => 0,
        comments => 'Length of the status effect.  10K and over: permament.  -10K and below: indefinite.',
    },
);
__PACKAGE__->set_primary_key('id_combatant_status');
__PACKAGE__->add_unique_constraint([qw(fkey_combatant fkey_status_effect)]);
__PACKAGE__->belongs_to(combatant => 'Games::Framework::RCP::Database::Result::Combatant', 'fkey_combatant');
__PACKAGE__->belongs_to(status_effect => 'Games::Framework::RCP::Database::Result::StatusEffect', 'fkey_status_effect');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The status effects that the combatants are inflicted with.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::CombatantStatus

=head1 VERSION

0.21

=head1 DESCRIPTION

The combatant status table keeps track of all of the different
status effects that the combatants may have, and for how long.

=head1 DATABASE TABLE

The status effects that the combatants are inflicted with.

=head2 id_combatant_status

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_combatant

This ID points to the Combatant table in a many to one mapping.
Each combatant can have many status effects simultaneously.

=head2 fkey_status_effect

This ID points to the Status Effects table in a many to one mapping.
The same status effect can be applied to many combatants.

=head2 length

This indicates the length of the status effect.  A convention is
used internally to represent many different possibilities.

=over 4

=item *

If the length is considered less than or equal to -10000,
then the status effect is in play indefinitely.

=item *

If the length is considered greater than or equal to 10000,
then the status effect is in play permamently.

=item *

If the length is between -10000 and 10000,
then the status effect ticks down normally.

=back

In general, when a status effect hits 0, it is the
Game Master's job to remove the effect.  There are
no triggers to do that automatically.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-CombatantStatus>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::CombatantStatus


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-CombatantStatus>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-CombatantStatus>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-CombatantStatus>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-CombatantStatus/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.