package Games::Framework::RCP::Database::Result::Class;

use 5.010;

use strict;
use warnings;

our $VERSION = '0.20';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('classes');
__PACKAGE__->add_columns(
    id_class => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the class.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 32,
        is_nullable => 0,
        comments => 'Name of the class.',
    },
    description => {
        data_type => 'varchar',
        size => 256,
        is_nullable => 0,
        comments => 'Description/flavortext of the class.',
    },
    fkey_kind => {
        data_type => 'integer',
        is_nullable => 0,
        comments => 'ID of the class kind.',
        extra => {unsigned => 1},
    },
    hp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'HP, or health.',
    },
    mp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'MP, or magical power',
    },
    pp => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'PP, or physical power',
    },
    spd => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Speed',
    },
    patk => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Attack',
    },
    matk => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Attack',
    },
    pdef => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Defense',
    },
    mdef => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Defense',
    },
    pacc => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Accuracy',
    },
    macc => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Accuracy',
    },
    pevd => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Physical Evade',
    },
    mevd => {
        data_type => 'numeric',
        is_nullable => 0,
        size => [12,4],
        comments => 'Magical Evade',
    },
);

__PACKAGE__->utf8_columns(qw/name description/);
__PACKAGE__->set_primary_key('id_class');
__PACKAGE__->add_unique_constraint(['name']);

__PACKAGE__->has_many(starting_statuses => 'Games::Framework::RCP::Database::Result::StartingStatus', 'fkey_class');
__PACKAGE__->many_to_many(statuses => 'starting_statuses', 'status_effect');

__PACKAGE__->belongs_to(kind => 'Games::Framework::RCP::Database::Result::ClassKind', 'fkey_kind');

__PACKAGE__->has_many(class_moves => 'Games::Framework::RCP::Database::Result::ClassMove', 'fkey_class');
__PACKAGE__->many_to_many(moves => 'class_moves', 'move');

__PACKAGE__->has_many(character_moves => 'Games::Framework::RCP::Database::Result::CharacterMove', 'fkey_class');

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('Simple listing of all jobs and their stats.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Class

=head1 VERSION

0.20

=head1 DESCRIPTION

The classes table contains the list of every single class
in the system.  Each class has its own statistics and
rules that players must follow.

Note that not every stat has to be used.  Many games
only use magic power and not physical/technique power,
and vice~versa.  Add columns as required for your own
home game.

=head1 DATABASE TABLE

Simple listing of all jobs and their stats.

=head2 id_class

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This is the name of the class.  Names MUST be unique.

=head2 description

This accepts 256 characters to add some flavortext to the
class.  Such text can be humurous, or it could
indicate what the class will do when summoned.

=head2 fkey_kind

This ID points to the ClassKind table in a one to one mapping.
This determines who can play the class.

=head2 hp

This is the class's starting health and max health.

=head2 mp

This is the class's starting magic power and max magic power.

=head2 pp

This is the class's starting physical power and max physical power.

=head2 spd

This is the class's starting speed.

=head2 patk

This is the class's starting physical attack.

=head2 matk

This is the class's starting magical attack.

=head2 pdef

This is the class's starting physical defense.

=head2 mdef

This is the class's starting magical defense.

=head2 pacc

This is the class's starting physical accuracy.

=head2 macc

This is the class's starting magical accuracy.

=head2 pevd

This is the class's starting physical evade.

=head2 mevd

This is the class's starting magical evade.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Class>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Class


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Class>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Class>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Class>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Class/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.