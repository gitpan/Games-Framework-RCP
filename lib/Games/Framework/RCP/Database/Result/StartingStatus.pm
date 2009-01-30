package Games::Framework::RCP::Database::Result::StartingStatus;

use strict;
use warnings;

our $VERSION = '0.21';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('starting_status');
__PACKAGE__->add_columns(
    id_starting_status => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the starting status effect.',
        extra => {unsigned => 1},
    },
    fkey_class => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the class.',
        extra => {unsigned => 1},
    },
    fkey_status_effect => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the status effect.',
        extra => {unsigned => 1},
    },
    'length' => {
        data_type => 'numeric',
        size => [12,4],
        is_nullable => 0,
        default_value => 10000,
        comments => 'Length of the status effect.  10K and over: permament.  -10K and below: indefinite.',
    },
    
);

__PACKAGE__->set_primary_key('id_starting_status');
__PACKAGE__->add_unique_constraint([qw(fkey_class fkey_status_effect)]);

__PACKAGE__->belongs_to(class => 'Games::Framework::RCP::Database::Result::Class', 'fkey_class');

__PACKAGE__->belongs_to(status_effect => 'Games::Framework::RCP::Database::Result::StatusEffect', 'fkey_status_effect');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The status effects classes start with.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::StartingStatus

=head1 VERSION

0.21

=head1 DESCRIPTION

The starting status table shows what status effects certain
classes start with upon joining the battle.  Most of the classes
in here will likely be boss classes who have certain status effect
protections.

=head1 DATABASE TABLE

The status effects classes start with.

=head2 id_starting_status

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fkey_class

This ID points to the Class table in a many to one mapping.
Many status effects may be given to a class.

=head2 fkey_status_effect

This ID points to the Status Effects table in a many to one mapping.
Many classes may start with the same status effect.

=head2 length

How long does the status effect last?
Remember: 10K and over is permament, while -10K and below is indefinite.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-StartingStatus>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::StartingStatus


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-StartingStatus>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-StartingStatus>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-StartingStatus>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-StartingStatus/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.