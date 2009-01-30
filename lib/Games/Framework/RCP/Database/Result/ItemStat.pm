package Games::Framework::RCP::Database::Result::ItemStat;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('item_stats');
__PACKAGE__->add_columns(
    id_item_stat => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the item stat modifier.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'Name of the stat to modify.  Usually is a column in the combatants table.',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 1,
        comments => 'Description of the stat to modify: meant for private.',
    }
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_item_stat');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->has_many(items_with_stats => 'Games::Framework::RCP::Database::Result::ItemWithStat', 'fkey_item_stat');
__PACKAGE__->many_to_many(items => 'items_with_stats', 'item_stats');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The list of the various stats that items can modify when used.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ItemStat

=head1 VERSION

0.21

=head1 DESCRIPTION

The item stats table contains a list of stats that can be
modified by the use of an item.  In general, this will
be one of the columns found in the
L<Combatant|Games::Framework::RCP::Database::Result::Combatant>
table.

=head1 DATABASE TABLE

The list of the various stats that items can modify when used.

=head2 id_item_stat

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This column will usually be filled with the name of the
stat to be modified.

=head2 description

This accepts 256 characters to add some flavortext to the
stat.  Such text can be humurous, or it could
indicate what the stat is used for.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ItemStat>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ItemStat


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ItemStat>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ItemStat>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ItemStat>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ItemStat/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.