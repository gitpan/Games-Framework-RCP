package Games::Framework::RCP::Setup;

use 5.010;

use warnings;
use strict;

use Data::Dumper;
use Sub::Exporter -setup => { exports => [ qw(login get_schema load_defaults load_custom) ] };

use Games::Framework::RCP::Database;

our $VERSION = '0.10';

my $schema;

sub login {
    $schema = Games::Framework::RCP::Database->connect( shift, shift, shift, shift, shift );
    return $schema;
}

sub get_schema {
    return $schema;
}

sub load_defaults {
    $schema->populate('VarBool', [
        [qw/name value/],
        ['colors_on', 1],
        ['join_time', 0],
        ['opposite_status_allowed', 1],
        ['poison_undead_hurts', 1],
        ['regen_undead_heals', 0],
        ['ct_decays_past_zero', 0],
        ['stop_stops_status', 1],
        ['frozen_stops_status', 0],
        ['ko_removes_effects', 1],
        ['seizure_undead_heals', 0],
        ['poison_every_x_ticks', 1],
        ['variable_haste', 1],
        ['variable_slow', 1],
        ['variable_regen', 1],
        ['variable_poison', 1],
        ['in_battle', 0],
        ['turnorder_shows_status', 0],
    ]);
    
    $schema->populate('VarInt', [
        [qw/name value/],
        ['fight_length', 0],
        ['poison_tick_checkpoint', 5],
        ['crit_rule', 1],
        ['ct_while_dead', 0],
        ['turn_at_ct', 500],
    ]);
    
    $schema->populate('VarReal', [
        [qw/name value/],
        ['old_crit_threshold', 20],
        ['haste_boost_percent', 20],
        ['slow_penalty_percent', 20],
        ['haste_boost_flex_percent', 5],
        ['slow_penalty_flex_percent', 5],
        ['regen_boost_percent', 10],
        ['poison_penalty_percent', 10],
        ['regen_boost_flex_percent', 2.5],
        ['poison_penalty_flex_percent', 2.5],
        ['crit_save_hp', 0.01],
        ['safeguard_protection', 80],
        ['adeath_protection', 80],
    ]);
    
    
    my %basic = (
        name => 'Basic',
        description => 'Nothing fancy, this class represents what just about everyone can do.',
        kind => {name => 'Unlocked', description => 'Everyone can play this class upon joining the battle.'},
        hp => 50,
        mp => 50,
        pp => 50,
        spd => 50,
        patk => 50,
        matk => 50,
        pdef => 50,
        mdef => 50,
        pacc => 50,
        macc => 50,
        pevd => 50,
        mevd => 50,
    );
    
    $schema->resultset('Class')->create(\%basic);
    
    my $job_id = $schema->resultset('Class')->single({ name => 'Basic' })->id_class;
    
    $schema->populate('MoveCost', [
        [qw/name description/],
        ['mp', 'This move costs a certain amount of mp.'],
        ['pp', 'This move costs a certain amount of pp.'],
        ['hp', 'This move costs a certain amount of hp.'],
        ['exp', 'This move costs a certain amount of exp.  Usually from primary job.'],
    ]);
    
    my $cost_id = $schema->resultset('MoveCost')->single({name => 'mp'})->id_move_cost;
    
    $schema->populate('MoveType', [
        [qw/name description/],
        ['Action', 'A normal type of move.'],
        ['Support', 'A skill that activates automatically at certain points.  Can be turned off when required.'],
        ['Reaction', 'A skill that must be called in reaction to an event.'],
    ]);
    
    my $type_id = $schema->resultset('MoveType')->single({name => 'Action'})->id_move_type;
    
    my @moves = (
        {
            name => 'Fight',
            fkey_move_type => $type_id,
            power => 10,
            description => 'A basic physical attack on the opponent.',
        },
        {
            name => 'Chi Burst',
            fkey_move_type => $type_id,
            power => 10,
            description => 'A basic magical attack on the opponent.',
        },
        {
            name => 'Pick Up',
            fkey_move_type => $type_id,
            description => 'Pick up an item off the arena floor.',
        },
        {
            name => 'Wait',
            fkey_move_type => $type_id,
            description => 'Do nothing this turn.  Advantages?  Well, there are a few...',
        },
    );
    
    foreach my $type_id (@moves)
    {
        $schema->resultset('Move')->create($type_id);
        
        my $move_id = $schema->resultset('Move')->single({name => $type_id->{name}})->id_move;
        
        $schema->resultset('ClassMove')->create({
            fkey_class => $job_id,
            fkey_move => $move_id,
        });
        
        if ($type_id->{name} eq 'Chi Burst')
        {
            $schema->resultset('MoveWithCost')->create({
                fkey_move => $move_id,
                fkey_move_cost => $cost_id,
                value => 5,
            });
        }
    }
    
    my @usages = (
        {
            name => 'Immediate Use',
            abbr => '[IU]',
            description => 'Upon touching/taking this item, it is immediately used on the carrier.',
        },
        {
            name => 'Immediate Use OK',
            abbr => '[IU OK]',
            description => 'Upon touching/taking this item, it can be immediately used by the carrier.',
        },
        {
            name => 'Full Turn',
            description => 'Using this item requires taking the full turn.',
        },
        {
            name => 'Reaction',
            abbr => '[React]',
            description => 'This item is only used as a reaction to an event.',
        },
    );
    
    foreach my $u_id (@usages)
    {
        $schema->resultset('ItemUsage')->create($u_id);
    }
    
    return 'Defaults loaded.';
}

sub load_custom
{
    my $custom = shift;
    foreach my $tablename (keys %{$custom} )
    {
        my $table = $custom->{$tablename};
        foreach my $row (@{$table})
        {
            $schema->resultset($tablename)->update_or_create($row);
        }
    }
    
    return 'Customs loaded.';
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Setup

=head1 VERSION

0.10

=head1 SYNOPSIS

 use Games::Framework::RCP::Setup qw/login load_defaults/;
 my $schema = login($data_source, $username, $password, $options, $on_connect);
 load_defaults();
 
 # Do whatever you want with the schema.

=head1 DESCRIPTION

The Setup file contains the basics needed to connect and setup the
database.  It does not abstract away all of the functionality
such as deploy(): it is up to the Game Master to actually deploy
the database.

=head1 SUBROUTINES/METHODS

=head2 login

This function accepts the same parameters as the traditional
DBI->connect.  The advantage of using login over DBI->connect
is that the schema object is returned right away.

=head2 get_schema

This function returns the current schema object.

=head2 load_defaults

This function loads the database with some initial data
to help get a Game Master started on hosting.

=head2 load_custom

This function allows others to load table data quickly
into the database without requiring access to other
modules.

This may be removed in the future.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Setup>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Setup


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Setup>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Setup>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Setup>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Setup/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.