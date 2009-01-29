package Games::Framework::RCP::Database::Result::MoveType;

use 5.010;

use strict;
use warnings;

our $VERSION = '0.20';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('move_types');
__PACKAGE__->add_columns(
    id_move_type => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the move type.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'Name of the move type.',
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
        comments => 'Description of the move type.',
    },
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_move_type');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->has_one(move => 'Games::Framework::RCP::Database::Result::Move', 'fkey_move_type');
__PACKAGE__->belongs_to(color => 'Games::Framework::RCP::Database::Result::Color', 'fkey_color');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The different move types available.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::MoveType

=head1 VERSION

0.20

=head1 DESCRIPTION

The move types table indicates the various types of moves that
can be performed.  Each move type has a certain use, and
mastering all of them could prove valueable.

=head1 DATABASE TABLE

The different move types available.

=head2 id_move_type

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 32 characters to identify the name of the move
type.  Needless to say, this is unique.

=head2 fkey_color

This ID points to the Color table in a one to one mapping.
Game Masters may want to color move types to make it easier
to identify.

=head2 description

This accepts 256 characters to add some flavortext to the
move type.  Such text can be humurous, or it could
indicate how the move with this type is supposed to be used.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-MoveType>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::MoveType


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-MoveType>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-MoveType>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-MoveType>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-MoveType/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.