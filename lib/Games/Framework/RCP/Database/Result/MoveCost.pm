package Games::Framework::RCP::Database::Result::MoveCost;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('move_costs');
__PACKAGE__->add_columns(
    id_move_cost => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the move cost.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'Name of the move cost.  Usually is a stat column.',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 1,
        comments => 'Description of the move cost: meant for private.',
    }
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_move_cost');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->has_many(moves_with_costs => 'Games::Framework::RCP::Database::Result::MoveWithCost', 'fkey_move_cost');
__PACKAGE__->many_to_many(moves => 'moves_with_costs', 'move_costs');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The list of the various move costs.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::MoveCost

=head1 VERSION

0.21

=head1 DESCRIPTION

The move costs table explains the various types of costs one
must fulfill in order to use a move.  While this will generally
be either mp or pp, other costs are possible for the creative
Game Masters.

=head1 DATABASE TABLE

The list of the various move costs.

=head2 id_move_cost

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 32 characters to identify the type of cost.
Needless to say, this must be unique.

=head2 description

This accepts 256 characters to add some flavortext to the
move cost.  Such text can be humurous, or it could
indicate what the cost is about.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-MoveCost>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::MoveCost


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-MoveCost>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-MoveCost>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-MoveCost>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-MoveCost/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.