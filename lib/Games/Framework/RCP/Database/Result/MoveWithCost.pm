package Games::Framework::RCP::Database::Result::MoveWithCost;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('moves_with_costs');
__PACKAGE__->add_columns(
    id_move_with_cost => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the move/cost combination.',
        extra => {unsigned => 1},
    },
    fkey_move => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the move.',
        extra => {unsigned => 1},
    },
    fkey_move_cost => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the move cost.',
        extra => {unsigned => 1},
    },
    value => {
        data_type => 'varchar',
        size => 16,
        is_nullable => 0,
        comments => 'The value of the cost for the move.',
    },
);

__PACKAGE__->utf8_columns(qw/value/);
__PACKAGE__->set_primary_key('id_move_with_cost');
__PACKAGE__->add_unique_constraint(['fkey_move', 'fkey_move_cost']);
__PACKAGE__->belongs_to(moves => 'Games::Framework::RCP::Database::Result::Move', 'fkey_move');
__PACKAGE__->belongs_to(move_costs => 'Games::Framework::RCP::Database::Result::MoveCost', 'fkey_move_cost');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every move with all of the their costs.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::MoveWithCost - Every move with all of the their costs.

=head1 VERSION

0.22

=head1 DESCRIPTION

The moves with costs table explains every cost associated with
every move.  Not all moves are free, and some even take a penalty.

=head1 DATABASE TABLE

Every move with all of the their costs.

=head2 id_move_with_cost

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_move

This ID points to the Move table in a many to one mapping.
There can be many costs to a single move.

=head2 fkey_move_cost

This ID points to the Move Costs table in a many to one mapping.
There can be many moves using the same cost.

=head2 value

This accepts 16 characters to identify the specific cost.
Not all costs are numeric, and the database allows for that.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-MoveWithCost>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::MoveWithCost


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-MoveWithCost>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-MoveWithCost>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-MoveWithCost>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-MoveWithCost/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.