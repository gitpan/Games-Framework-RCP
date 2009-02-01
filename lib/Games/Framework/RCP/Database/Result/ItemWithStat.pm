package Games::Framework::RCP::Database::Result::ItemWithStat;

use strict;
use warnings;
use utf8;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('items_with_stats');
__PACKAGE__->add_columns(
    id_item_with_stat => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the item/stat combination.',
        extra => {unsigned => 1},
    },
    fkey_item => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the item.',
        extra => {unsigned => 1},
    },
    fkey_item_stat => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the stat being modified.',
        extra => {unsigned => 1},
    },
    value => {
        data_type => 'varchar',
        size => 16,
        is_nullable => 0,
        comments => 'The value of the stat for modification.',
    },
    operator => {
        data_type => 'varchar',
        size => 4,
        is_nullable => 0,
        default_value => '+',
        comments => 'The operator to use on the value.',
    },
);

__PACKAGE__->utf8_columns(qw/value operator/);
__PACKAGE__->set_primary_key('id_item_with_stat');
__PACKAGE__->add_unique_constraint(['fkey_item', 'fkey_item_stat']);
__PACKAGE__->belongs_to(items => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item');
__PACKAGE__->belongs_to(item_stats => 'Games::Framework::RCP::Database::Result::ItemStat', 'fkey_item_stat');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Every item that gives a stat change upon using.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ItemWithStat - Every item that gives a stat change upon using.

=head1 VERSION

0.22

=head1 DESCRIPTION

The items with stats table shows what stats are modified by
using particular items.  Each item can modify a combatant's
stats in various ways.  Knoweldge of what stats are modified
can be useful.

=head1 DATABASE TABLE

Every item that gives a stat change upon using.

=head2 id_item_with_stat

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_item

This ID points to the Item table in a many to one mapping.
Each item can affect many stats.

=head2 fkey_item_stat

This ID points to the Item Stats table in a many to one mapping.
Each item stat can be affected with many items.

=head2 value

This is the value for which a stat is modified.  This does
not tell the whole story: see the operator column below.

=head2 operator

This is the operator that is applied with the value on
the stat to get its new value.  Examples of some operators
could include:

=over 4

=item + adding

=item − subtracting

=item × multiplying

=item ÷ dividing

=item % percentage

=back

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ItemWithStat>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ItemWithStat


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ItemWithStat>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ItemWithStat>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ItemWithStat>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ItemWithStat/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.