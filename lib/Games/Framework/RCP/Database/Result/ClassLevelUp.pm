package Games::Framework::RCP::Database::Result::ClassLevelUp;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('class_level_up');
__PACKAGE__->add_columns(
    id_level_up => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the level up package.',
        extra => {unsigned => 1},
    },
    fkey_class => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the class.',
        extra => {unsigned => 1},
    },
    stat_col => {
        data_type => 'varchar',
        size => 4,
        is_nullable => 0,
        comments => 'The stat to level up.',
    },
    value => {
        data_type => 'numeric',
        size => [12,4],
        is_nullable => 0,
        comments => 'The amount to raise the stat for every one level.',
    },
    
);

__PACKAGE__->utf8_columns(qw/stat_col/);
__PACKAGE__->set_primary_key('id_level_up');
__PACKAGE__->belongs_to(class => 'Games::Framework::RCP::Database::Result::Class', 'fkey_class');
__PACKAGE__->add_unique_constraint( [qw(fkey_class stat_col)] );

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The awards for leveling up a class.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::ClassLevelUp

=head1 VERSION

0.21

=head1 DESCRIPTION

The class_level_up table shows what stats are boosted
(or penalized) upon leveling up.

=head1 DATABASE TABLE

The awards for leveling up a class.

=head2 id_level_up

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_class

This ID points to the Class table in a many to many mapping.
Not all characters get to be a part of the callscript.

=head2 stat_col

This is the name of the stat that gets modified.
Usually, the name here will match a column in the Class table.

=head2 value

This is how much to increment the stat on the previous column
for those that have levels in this class.  It uses
numeric(12,4) for guaranteed precision.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-ClassLevelUp>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::ClassLevelUp


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-ClassLevelUp>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-ClassLevelUp>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-ClassLevelUp>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-ClassLevelUp/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.