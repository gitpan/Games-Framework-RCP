# $Revision: 0.04 $
# $Date: Sun Dec 21 18:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Utilities.pm $

package Games::Framework::RCP::Utilities;

use 5.010;

use warnings;
use strict;
use utf8;

our $VERSION = '0.04';

1;

__END__

=head1 DISCLAIMER

This software is currently under development.  It is not done.
While it will not be done quickly, contributions can help
make things go faster.  Please contribute if you can.

=head1 NAME

Games::Framework::RCP::Utilities - Details of the Utilities Tables & Views

=head1 VERSION

Version 0.04

=head1 DEPENDENCIES

As this is a documentation module, there are no dependencies.

=head1 SYNOPSIS

Games::Framework::RCP::Utilities - Module that describes the SQL tables and views
used by this part of the database.  In PostGresQL, this would be the schema.

=head1 DESCRIPTION

The Games::Framework::RCP::Utilities module is a documentation module that
describes what uses the utility based database tables and views.
Following PostGresQL schema organization, this module effectively
represents the utilities schema.

=head1 CONFIGURATION AND ENVIRONMENT

As this is a documentation module, no configuring is required.

=head1 TABLES

The four tables are listed below in alphabetical order:

=over

=item *

L</colors>

=item *

L</vars_bool>

=item *

L</vars_ints>

=item *

L</vars_real>

=back

=head2 colors

=for html
<table>
	<caption>IRC color values.</caption>
	<thead><tr>
		<th>Column</th>
		<th>Type</th>
		<th>Null?</th>
		<th>Default</th>
		<th>Constraints</th>
		<th>Comment</th>
	</tr></thead>
	<tbody>
		<tr>
			<td>id_color</td>
			<td>smallint</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[pk]</td>
			<td>ID of the color.</td>
		</tr>
		<tr>
			<td>fg</td>
			<td>smallint</td>
			<td>NOT NULL</td>
			<td></td>
			<td></td>
			<td>FG color.</td>
		</tr>
		<tr>
			<td>bg</td>
			<td>smallint</td>
			<td>NOT NULL</td>
			<td></td>
			<td>PRIMARY KEY</td>
			<td>BG color.</td>
		</tr>
	</tbody>
</table>

=begin text

Column      Type        Not Null    Default     Constraints Comment
id_color    smallint    NOT NULL                [pk]        ID of the color.
fg          smallint    NOT NULL                            FG color.
bg          smallint    NOT NULL                            BG color.

=end text

The colors table is used to give any person, place, or thing some color.
There is a foreground color and a background color available for each.
At present, the colors represent the 16 colors that IRC uses.

=head2 vars_bool

=for html
<table>
	<caption>Various boolean variables in use.</caption>
	<thead><tr>
		<th>Column</th>
		<th>Type</th>
		<th>Null?</th>
		<th>Default</th>
		<th>Constraints</th>
		<th>Comment</th>
	</tr></thead>
	<tbody>
		<tr>
			<td>id_variable</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>AUTO_INCREMENT</td>
			<td>[pk]</td>
			<td>ID of the variable.</td>
		</tr>
		<tr>
			<td>name</td>
			<td>varchar(32)</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[uniq]</td>
			<td>Name of the variable.</td>
		</tr>
		<tr>
			<td>value</td>
			<td>boolean</td>
			<td>NOT NULL</td>
			<td>true</td>
			<td></td>
			<td>Value of the variable.</td>
		</tr>
	</tbody>
</table>

=begin text

Column          Type        Not Null    Default         Constraints Comment
id_variable     integer     NOT NULL    AUTO_INCREMENT  [pk]        ID of the variable.
name            varchar(32) NOT NULL                    [uniq]      Name of the variable.
value           boolean     NOT NULL    true                        Value of the variable.

=end text

The vars_bool table contains the majority of the various fighting variables
that may take place during battle.  Not everyone has the same preference,
and thus can change them using
L<Games::Framework::RCP::Utilities::Vars_Bool|Games::Framework::RCP::Utilities::Vars_Bool>.

The variables currently in use are as follows, in alphabetical order:

=over

=item *

B<colors_on> - are colors allowed to be used in this context?
Set this to FALSE if you are in an environment that does not
allow for colors, like some IRC channels.

=item *

B<ct_decays_past_zero> - If your CT (Charge Time)
decays when you are dead, can you end up with negative CT?
Set this to TRUE to be a slightly sadistic Game Master.

=item *

B<frozen_stops_status> - If you are frozen, does only the frozen
status timer tick down, or do all status effects tick down with it?

=item *

B<in_battle> - Are you currently hosting a battle?

=item *

B<join_time> - Can player characters join the battle?
This should be kept TRUE only for a limited time.

=item *

B<ko_removes_effects> - Should being knocked out remove most status effects?
Note that some status effects can't be removed this way.

=item *

B<opposite_status_allowed> - Can fighters have conflicting status effects
going on at once?  Example: Can a fighter have both Attack Up and Attack Down
at the same time?  Depending on the status effects, the two may not
necessarily cancel each other out (see below).

=item *

B<poison_every_x_ticks> - Should poison damage be calculated after every
x number of ticks?  If set to FALSE, poison will be applied at the end
of a fighter's turn.

=item *

B<poison_undead_hurts> - Should poison hurt those that are undead?

=item *

B<regen_undead_heals> - Should regen heal those that are undead?

=item *

B<seizure_undead_heals> - Should seizure heal those that are undead?
Seizure drains HP per tick.

=item *

B<stop_stops_status> - If you are stopped, does only the stop
status timer tick down, or do all status effects tick down with it?

=item *

B<turnorder_shows_status> - If a turnorder is generated, should it show
when status effects time out?  Note that this variable only applies on
the driver programs: this variable is not directly used in the provided modules.

=item *

B<variable_haste> - Does the haste status effect give a variable boost
in speed, or fixed?  If TRUE, see the corresponding entry in the
vars_real table.

=item *

B<variable_poison> - Does the poison status effect give a variable drain
in health, or fixed?  If TRUE, see the corresponding entry in the
vars_real table.

=item *

B<variable_regen> - Does the regen status effect give a variable boost
in health, or fixed?  If TRUE, see the corresponding entry in the
vars_real table.

=item *

B<variable_slow> - Does the slow status effect give a variable drain
in speed, or fixed?  If TRUE, see the corresponding entry in the
vars_real table.

=back

=head2 vars_ints

=for html
<table>
	<caption>Various integer variables in use.</caption>
	<thead><tr>
		<th>Column</th>
		<th>Type</th>
		<th>Null?</th>
		<th>Default</th>
		<th>Constraints</th>
		<th>Comment</th>
	</tr></thead>
	<tbody>
		<tr>
			<td>id_variable</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>AUTO_INCREMENT</td>
			<td>[pk]</td>
			<td>ID of the variable.</td>
		</tr>
		<tr>
			<td>name</td>
			<td>varchar(32)</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[uniq]</td>
			<td>Name of the variable.</td>
		</tr>
		<tr>
			<td>value</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>0</td>
			<td></td>
			<td>Value of the variable.</td>
		</tr>
	</tbody>
</table>

=begin text

Column          Type        Not Null    Default         Constraints Comment
id_variable     integer     NOT NULL    AUTO_INCREMENT  [pk]        ID of the variable.
name            varchar(32) NOT NULL                    [uniq]      Name of the variable.
value           integer     NOT NULL    0                           Value of the variable.

=end text

The vars_ints table contains mainly variables used to help
move the battle along.  While a few should be left alone in
most circumstances, other variables may be messed with freely
using
L<Games::Framework::RCP::Utilities::Vars_Ints|Games::Framework::RCP::Utilities::Vars_Ints>.

The variables currently in use are listed below in alphabetical order:

=over 4

=item *

B<crit_rule> - What type of critical rule will be used to protect against
dying too quickly?

=over 8

=item *

I<0> - There is no critical rule.  Fighters can die at any time.

=item *

I<1> - If above a certain percentage in health, fighters can't die due
to health damage.  OHKO moves can still kill, however.

=item *

I<2> - After receiving damage, a die roll is cast to see if the
fighter can survive from being sent to death.  It is easier
to survive with higher health than lower health, but survival is
still possible.

=back

=item *

B<ct_while_dead> - What happens to a fighter's CT when they are knocked out?

=over 8

=item *

I<-1> - While dead, CT decays downward.  Revive the fighter to stop the downward spiral.

=item *

I<0> - The CT value of the fighter stays put.  Do nothing.

=item *

I<1> - The CT value increases as if the fighter was alive.

=back

=item *

B<fight_length> - How long has the battle last so far?  This value should
be reset to 0 at the start of each match, and incremented when it is
time to increase fighters' CT.

=item *

B<poison_tick_checkpoint> - At every how many ticks will poison be applied?
Note that if B<poison_every_x_ticks> is set to FALSE, this value should be
ignored.

=item *

B<turn_at_ct> - When a fighter's CT value reaches this value, he may act.
This is generally set to 500.

=back

=head2 vars_real

=for html
<table>
	<caption>Various integer variables in use.</caption>
	<thead><tr>
		<th>Column</th>
		<th>Type</th>
		<th>Null?</th>
		<th>Default</th>
		<th>Constraints</th>
		<th>Comment</th>
	</tr></thead>
	<tbody>
		<tr>
			<td>id_variable</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>AUTO_INCREMENT</td>
			<td>[pk]</td>
			<td>ID of the variable.</td>
		</tr>
		<tr>
			<td>name</td>
			<td>varchar(32)</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[uniq]</td>
			<td>Name of the variable.</td>
		</tr>
		<tr>
			<td>value</td>
			<td>real</td>
			<td>NOT NULL</td>
			<td>0</td>
			<td></td>
			<td>Value of the variable.</td>
		</tr>
	</tbody>
</table>

=begin text

Column          Type        Not Null    Default         Constraints Comment
id_variable     integer     NOT NULL    AUTO_INCREMENT  [pk]        ID of the variable.
name            varchar(32) NOT NULL                    [uniq]      Name of the variable.
value           real        NOT NULL    0                           Value of the variable.

=end text

Real number variables work similarly to the vars_ints variables above,
only they can accept decimal values as well as integers.  Many settings
can be changed here to a Game Master's liking: do so at
L<Games::Framework::RCP::Utilities::Vars_Real|Games::Framework::RCP::Utilities::Vars_Real>.

The variables in this table are listed below in alphabetical order:

=over 4

=item *

B<adeath_protection> - What is the percentage that the ADeath status
effect will protect a fighter from OHKOs?  This value is normally
kept between 0 and 100.

=item *

B<crit_save_hp> - If the critical rule saves a fighter from death,
what is the resulting HP set to?  It defaults to 0.01, which tells the
teammates to heal him quickly.  This can be set to an obscene battle to
make battles more challenging/frustrating.

=item *

B<haste_boost_flex_percent> - If B<variable_haste> is TRUE, the haste
value for the tick becomes B<haste_boost_percent> ± this value.

=item *

B<haste_boost_percent> - This is the percentage of speed boost provided
by the haste status effect.  If B<variable_haste> is TRUE, the range
is extended by ± B<haste_boost_flex_percent>.

=item *

B<old_crit_threshold> - If using B<crit_rule> value 1, this is the
percentage that fighters try to avoid falling below in order to avoid
being critical, and thus susceptible to dying.  A value of 100 or
higher effectively replicates B<crit_rule> value 0.

=item *

B<poison_penalty_flex_percent> - If B<variable_poison> is TRUE, the poison
value for the tick becomes B<poison_penalty_percent> ± this value.

=item *

B<poison_penalty_percent> - This is the percentage of health drain provided
by the poison status effect.  If B<variable_poison> is TRUE, the range
is extended by ± B<poison_penalty_flex_percent>.

=item *

B<regen_boost_flex_percent> - If B<variable_regen> is TRUE, the regen
value for the tick becomes B<regen_boost_percent> ± this value.

=item *

B<regen_boost_percent> - This is the percentage of health boost provided
by the regen status effect.  If B<variable_regen> is TRUE, the range
is extended by ± B<regen_boost_flex_percent>.

=item *

B<safeguard_protection> - What is the percentage that the Safeguard status
effect will protect a fighter from status ailments?  This value is normally
kept between 0 and 100.

=item *

B<slow_penalty_flex_percent> - If B<variable_slow> is TRUE, the slow
value for the tick becomes B<slow_penalty_percent> ± this value.

=item *

B<slow_penalty_percent> - This is the percentage of speed drain provided
by the slow status effect.  If B<variable_slow> is TRUE, the range
is extended by ± B<slow_penalty_flex_percent>.

=back

=head1 SUBROUTINES/METHODS

There are no subroutines in this module.

=head1 INCOMPATIBILITIES

There are no known incompatibilities in this module.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Utilities>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Utilities


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Utilities>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Utilities>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Utilities>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Utilities/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.