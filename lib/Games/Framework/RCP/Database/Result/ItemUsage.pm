package Games::Framework::RCP::Database::Result::ItemUsage;

use 5.010;

use strict;
use warnings;

our $VERSION = '0.20';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('item_usages');
__PACKAGE__->add_columns(
    id_item_usage => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the item usage.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'Name of the item usage.',
    },
    abbr => {
        data_type => 'varchar',
        size => 8,
        is_nullable => 1,
        default_value => undef,
        comments => 'Abbreviation of the item usage: meant for public.',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 1,
        comments => 'Description of the item usage: meant for private.',
    }
);

__PACKAGE__->utf8_columns(qw/name abbr description/);
__PACKAGE__->set_primary_key('id_item_usage');
__PACKAGE__->add_unique_constraint(['name']);
__PACKAGE__->add_unique_constraint(['abbr']);
__PACKAGE__->has_one(item => 'Games::Framework::RCP::Database::Result::Item', 'fkey_item_usage');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The list of the various item usages.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ItemUsage

=head1 VERSION

0.20

=head1 DESCRIPTION

The item usages table explains how the items can be used
during battle.

=head1 DATABASE TABLE

The list of the various item usages.

=head2 id_item_usage

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 32 characters to identify how the item
is used.  This must be UNIQUE.

=head2 abbr

This is an 8 letter abbreviation of the above name.
It is this version that the Game Master should consider
making public.

=head2 description

This accepts 256 characters to add some flavortext to the
item usage.  Such text can be humurous, or it could
indicate what how the item is used in detail.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ItemUsage>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ItemUsage


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ItemUsage>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ItemUsage>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ItemUsage>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ItemUsage/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.