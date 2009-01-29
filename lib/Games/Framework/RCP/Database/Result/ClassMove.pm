package Games::Framework::RCP::Database::Result::ClassMove;

use 5.010;

use strict;
use warnings;

our $VERSION = '0.20';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('class_moves');
__PACKAGE__->add_columns(
    id_class_move => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the class/move combination.',
        extra => {unsigned => 1},
    },
    fkey_class => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the class.',
        extra => {unsigned => 1},
    },
    fkey_move => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the move.',
        extra => {unsigned => 1},
    },
    cost => {
        data_type => 'numeric',
        size => [12,4],
        default_value => 0,
        is_nullable => 1,
        comments => 'The amount needed by a player to buy the move permamently.',
    }
);

__PACKAGE__->set_primary_key('id_class_move');
__PACKAGE__->add_unique_constraint(['fkey_class', 'fkey_move']);
__PACKAGE__->belongs_to(moves => 'Games::Framework::RCP::Database::Result::Move', 'fkey_move');
__PACKAGE__->belongs_to(classes => 'Games::Framework::RCP::Database::Result::Class', 'fkey_class');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The moves each class has, along with how much to buy.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ClassMove

=head1 VERSION

0.20

=head1 DESCRIPTION

The class moves table shows what moves each class knows,
along with how much EXP is required to buy the move permamently.
Depending on the Game Master, playing a class as a primary
may allow access to all of the moves with no penalty.

=head1 DATABASE TABLE

The moves each class has, along with how much to buy.

=head2 id_calls_move

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_class

This ID points to the Class table in a many to many mapping.

=head2 fkey_move

This ID points to the Move table in a many to many mapping.

=head2 cost

This numeric value is the amount of EXP a player must spend
in order to gain the move permamently.  Move that cost
0 are freely available.  Move that are NULL can not be used
outside of the primary class.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ClassMove>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ClassMove


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ClassMove>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ClassMove>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ClassMove>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ClassMove/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.