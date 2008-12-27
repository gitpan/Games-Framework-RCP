# $Revision: 0.04 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Data.pm $

package Games::Framework::RCP::Battle;

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

Games::Framework::RCP::Battle - Details of the Battle Tables and Views

=head1 VERSION

Version 0.04

=head1 DEPENDENCIES

As this is a documentation module, there are no dependencies.

=head1 SYNOPSIS

Games::Framework::RCP::Battle - Module that describes the SQL tables and views
used by this part of the database.  In PostGresQL, this would be the schema.

=head1 DESCRIPTION

The Games::Framework::RCP::Battle module is a documentation module that
describes what uses the battle based database tables and views.
Following PostGresQL schema organization, this module effectively
represents the battle schema.

=head1 CONFIGURATION AND ENVIRONMENT

As this is a documentation module, no configuring is required.

=head1 TABLES

The two tables are listed below in alphabetical order:

=over

=item *

L</combatants>

=item *

L</fighter_status>

=back

=head2 combatants

=for html
<table>
	<caption>The lineup of fighters.</caption>
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
			<td>join_time</td>
			<td>datetime</td>
			<td>NOT NULL</td>
			<td>now()</td>
			<td></td>
			<td>What time did the fighter join?</td>
		</tr>
		<tr>
			<td>fkey_character</td>
			<td>bigint</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk][uniq]</td>
			<td>The character that is fighting.</td>
		</tr>
		<tr>
			<td>fkey_job</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk]</td>
			<td>The job the character is fighting with.</td>
		</tr>
		<tr>
			<td>secondary</td>
			<td>varchar(32)</td>
			<td>NULL</td>
			<td></td>
			<td></td>
			<td>secondary skillset</td>
		</tr>
		<tr>
			<td>aux</td>
			<td>varchar(32)</td>
			<td>NULL</td>
			<td></td>
			<td></td>
			<td>auxillary skill</td>
		</tr>
		<tr>
			<td>ct</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>int rand 500</td>
			<td></td>
			<td>CT.  randomized at the start.</td>
		</tr>
		<tr>
			<td>id_fighter</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>1</td>
			<td>[pk]</td>
			<td>ID of the fighter.</td>
		</tr>
		<tr>
			<td>hp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>HP of the fighter.</td>
		</tr>
		<tr>
			<td>mp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>MP of the fighter.</td>
		</tr>
		<tr>
			<td>pp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>PP of the fighter.</td>
		</tr>
		<tr>
			<td>spd</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Speed of the fighter.</td>
		</tr>
		<tr>
			<td>patk</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Physical Attack</td>
		</tr>
		<tr>
			<td>matk</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Magical Attack</td>
		</tr>
		<tr>
			<td>pdef</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Physical Defense</td>
		</tr>
		<tr>
			<td>mdef</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Magical Defense</td>
		</tr>
		<tr>
			<td>pacc</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Physical Accuracy</td>
		</tr>
		<tr>
			<td>macc</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Magical Accuracy</td>
		</tr>
		<tr>
			<td>pevd</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Physical Evade</td>
		</tr>
		<tr>
			<td>mevd</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Magical Evade</td>
		</tr>
		<tr>
			<td>max_hp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Max HP</td>
		</tr>
		<tr>
			<td>max_mp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Max MP</td>
		</tr>
		<tr>
			<td>max_pp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Max PP</td>
		</tr>
		<tr>
			<td>fkey_job</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>1</td>
			<td>[fk]</td>
			<td>The job the fighter starts with.  Used for rewards and such.</td>
		</tr>
	</tbody>
</table>

=begin text

Column          Type            Not Null    Default         Constraints Comment
join_time       datetime        NOT NULL    now()                       What time did the fighter join?
fkey_character  bigint          NOT NULL                    [fk][uniq]  The character that is fighting.
fkey_job        integer         NOT NULL                    [fk]        The job the character is fighting with.
secondary       varchar(32)                 NULL                        secondary skillset
aux             varchar(32)                 NULL                        auxillary skill
ct              numeric(12,4)   NOT NULL    int rand 500                CT.  randomized at the start.
id_fighter      bigint          NOT NULL    1               [pk]        ID of the fighter.
hp              numeric(12,4)   NOT NULL    50                          HP of the fighter.
mp              numeric(12,4)   NOT NULL    50                          MP of the fighter.
pp              numeric(12,4)   NOT NULL    50                          PP of the fighter.
spd             numeric(12,4)   NOT NULL    50                          Speed of the fighter.
patk            numeric(12,4)   NOT NULL    50                          Physical Attack
matk            numeric(12,4)   NOT NULL    50                          Magical Attack
pdef            numeric(12,4)   NOT NULL    50                          Physical Defense
mdef            numeric(12,4)   NOT NULL    50                          Magical Defense
pacc            numeric(12,4)   NOT NULL    50                          Physical Accuracy
macc            numeric(12,4)   NOT NULL    50                          Magical Accuracy
pevd            numeric(12,4)   NOT NULL    50                          Physical Evade
mevd            numeric(12,4)   NOT NULL    50                          Magical Evade
max_hp          numeric(12,4)   NOT NULL    50                          Max HP
max_mp          numeric(12,4)   NOT NULL    50                          Max MP
max_pp          numeric(12,4)   NOT NULL    50                          Max PP
starting_job    integer         NOT NULL    1               [fk]        The job the fighter starts with.  Used for rewards and such.

=end text

The combatants table shows who is fighting as what jobs,
along with their various stats.  When fighters join,
their CT is randomized to a number between 0 and 499.
The job fighters start as is stored for ease of rewarding
purposes.

For those looking for a fighter's collection of status
effects or inventory, check the tables below.

A note on id_fighter: it is NOT using a sequence number.
This is by design: after battles end, fighters are to
be wiped out of the battle data.  Instead, make the
next fighter MAX(id_fighter) + 1, or 1 if no one is
in the battle data yet.

=head2 fighter_status

=for html
<table>
	<caption>What status effects do the fighters have?</caption>
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
			<td>fkey_combatant</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk][pk]</td>
			<td>The fighter.</td>
		</tr>
		<tr>
			<td>fkey_status</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk][pk]</td>
			<td>The status effect.</td>
		</tr>
		<tr>
			<td>length</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>21</td>
			<td></td>
			<td>The length.  If -10K or less: indefinite. If 10K or more: permament.</td>
		</tr>
	</tbody>
</table>

=begin text

Column          Type            Not Null    Default Constraints Comment
fkey_combatant  integer         NOT NULL            [fk][pk]    The fighter.
fkey_status     integer         NOT NULL            [fk][pk]    The status effect.
length          numeric(12,4)   NOT NULL    21                  The length.  If -10K or less: indefinite. If 10K or more: permament.

=end text

The fighter_status table contains all of the status effects
that have inflicted the fighters, whether for good or ill.

As battles should not last more than 10000 ticks (and those that
do are probably not being run properly), a convention is in use
with this table.  If a status effect's length is considered less than
10000, then the status effect is to last indefinitely until an
unknown time, maybe forever.  If a status effect's length is considered
more than 10000, then the status effect is a permament part of the fighter
and should not be removed for most reasons.  Needless to say, a Game
Master can choose to overrule this at any time.

A note on fkey_combatant: its a foreign key to the combatants table above.

=head1 VIEWS

Information on the views is coming soon.

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
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Battle>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Battle


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Battle>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Battle>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Battle>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Battle/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
