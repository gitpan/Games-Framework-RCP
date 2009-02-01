package Games::Framework::RCP::Database::Result::StatusEffect;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('status_effects');
__PACKAGE__->add_columns(
    id_status_effect => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the status effect.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'Name of the status effect.',
    },
    abbr => {
        data_type => 'varchar',
        size => 8,
        is_nullable => 1,
        default_value => undef,
        comments => 'Abbreviation of the status effect.',
    },
    description => {
        data_type => 'varchar',
        size => 100,
        is_nullable => 0,
        comments => 'Description/flavortext of the status effect.',
    },
    fkey_color => {
        data_type => 'integer',
        is_nullable => 1,
        default_value => undef,
        comments => 'Color of the status effect.',
    },
    is_good => {
        data_type => 'boolean',
        is_nullable => 1,
        default_value => 'true',
        comments => 'Is the status effect generally helpful?  NULL = Neutral.',
    },
    is_secret => {
        data_type => 'boolean',
        is_nullable => 0,
        default_value => 'false',
        comments => 'Is the status effect generally hidden from the public?',
    },
    default_length => {
        data_type => 'numeric',
        size => [12,4],
        is_nullable => 0,
        default_value => 31,
        comments => 'The default length of the status effect.  10K and over: permament.  -10K and below: indefinite.',
    },
    
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_status_effect');
__PACKAGE__->add_unique_constraint( [qw(name)] );

__PACKAGE__->has_many(starting_statuses => 'Games::Framework::RCP::Database::Result::StartingStatus', 'fkey_status_effect');
__PACKAGE__->many_to_many(statuses => 'starting_statuses', 'class');

__PACKAGE__->has_many(items_with_statuses => 'Games::Framework::RCP::Database::Result::ItemWithStatus', 'fkey_status_effect');
__PACKAGE__->many_to_many(items => 'items_with_statuses', 'status_effects');

__PACKAGE__->belongs_to(color => 'Games::Framework::RCP::Database::Result::Color', 'fkey_color');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The big list of status effects.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::StatusEffect - The big list of status effects.

=head1 VERSION

0.22

=head1 DESCRIPTION

The status effects table contains every status effect that
is in use by the Game Master.  Each effect can affect the
combatants in different ways.

=head1 DATABASE TABLE

The big list of status effects.

=head2 id_status_effect

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 32 characters to identify the name of the
status effect.  Needless to say, this is unique.

=head2 abbr

This is an 8 letter abbreviation of the above name.  While
not required to be unique, it is a good idea.

=head2 description

This accepts 256 characters to add some flavortext to the
character.  Such text can be humurous, or it could
indicate what the character will do when summoned.

=head2 fkey_color

This ID points to the Color table in a one to one mapping.
A color given to a status effect may make it easier to identify.

=head2 is_good

This boolean indicates whether the status effect is beneficial
or not.  Status effects that are neither are given NULL.

=head2 is_secret

This boolean indicates whether the status effect is considered
a secret to everyone but the ref.  This defaults to false.

=head2 default_length

This indicates the default amount of time the status effect
lasts once given to a combatant.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-StatusEffect>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::StatusEffect


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-StatusEffect>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-StatusEffect>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-StatusEffect>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-StatusEffect/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.