package Games::Framework::RCP::Database::Result::HazardSet;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('hazard_sets');
__PACKAGE__->add_columns(
    id_hazard_set => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the hazard set.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 64,
        is_nullable => 0,
        comments => 'Name of the hazard set.',
    },
    description => {
        data_type => 'varchar',
        size => 100,
        is_nullable => 0,
        comments => 'Description/flavortext of the hazard set.',
    },
    fkey_color => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => undef,
        comments => 'Color of the hazard set.',
    },
    weight => {
        data_type => 'real',
        default_value => 1,
        comments => 'How likely is it for this hazard set to be chosen?',
        extra => {unsigned => 1},
        accessor => '_weight',
    },
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_hazard_set');
__PACKAGE__->add_unique_constraint( [qw(name)] );

__PACKAGE__->belongs_to(color => 'Games::Framework::RCP::Database::Result::Color', 'fkey_color');

__PACKAGE__->has_many(hazard => 'Games::Framework::RCP::Database::Result::Hazard', 'fkey_hazard_set');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The big list of hazard sets.');
}

sub weight {
    my $self = shift;
    
    my $weight = $self->_weight;
    
    return 0 if $weight <= 0;
    
    return $weight * rand;
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::HazardSet - The big list of hazard sets.

=head1 VERSION

0.22

=head1 DESCRIPTION

The hazard sets table contains a list of every unique hazard set.
Hazards are random elements that can cause a battle to take
a different turn.  Not all battles will use hazards, but it
is provided for convenience.

For those that have played Super Smash Bros, the items that drop
at regular intervals are a form of hazard.  The items that drop
can change the face of the battle, depending on how useful the
item is.

=head1 DATABASE TABLE

The big list of hazard sets.

=head2 id_hazard_set

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 64 characters to identify the name of the
hazard set.  Needless to say, this is unique.

=head2 description

This accepts 256 characters to add some flavortext to the
hazard set.  Such text can be humurous, or it could
indicate what the hazard set is generally about.

=head2 fkey_color

This ID points to the Color table in a one to one mapping.
A color given to a status effect may make it easier to identify.

=head2 weight

Every hazard set has a certain chance to be chosen.  By
default, all hazard sets have a weight of 1, showing equal
chance.  Game Masters can change the weight of hazard sets
so that certain ones show up more than others.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head2 weight()

weight returns the row's weight times a random number.
weight by itself is pointless.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-HazardSet>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::HazardSet


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-HazardSet>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-HazardSet>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-HazardSet>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-HazardSet/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.