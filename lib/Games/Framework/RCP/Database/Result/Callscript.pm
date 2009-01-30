package Games::Framework::RCP::Database::Result::Callscript;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('callscript');
__PACKAGE__->add_columns(
    id_callscript => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the callscript character.',
        extra => {unsigned => 1},
    },
    fkey_character => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the general character.',
        extra => {unsigned => 1},
    },
    description => {
        data_type => 'varchar',
        size => 255,
        is_nullable => 0,
        comments => 'Flavortext for the callscript character.',
    },
);

__PACKAGE__->utf8_columns(qw/description/);
__PACKAGE__->set_primary_key('id_callscript');
__PACKAGE__->add_unique_constraint(['fkey_character']);
__PACKAGE__->belongs_to(character => 'Games::Framework::RCP::Database::Result::Character', 'fkey_character');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Listing of which characters are in a callscript: think grab bag.');
    return;
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Callscript

=head1 VERSION

0.21

=head1 DESCRIPTION

The callscript table contains a list of characters that can be pulled from
a "hat" of sorts at random for various different things.  This is mainly
available as a convenience for Game Masters who require random people,
but have those people be someone established previously.

=head1 DATABASE TABLE

Listing of which characters are in a callscript: think grab bag.

=head2 id_callscript

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_character

This ID points to the Character table in a one to one mapping.
Not all characters get to be a part of the callscript.

=head2 description

This accepts 256 characters to add some flavortext to the
character.  Such text can be humurous, or it could
indicate what the character will do when summoned.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Callscript>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Callscript


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Callscript>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Callscript>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Callscript>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Callscript/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.