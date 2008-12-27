# $Revision: 0.04 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Data.pm $

package Games::Framework::RCP::Data;

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

Games::Framework::RCP::Data - Details of the Data Tables and Views

=head1 VERSION

Version 0.04

=head1 DEPENDENCIES

As this is a documentation module, there are no dependencies.

=head1 SYNOPSIS

As this is a doucmentation module, there is no synopsis.

=head1 DESCRIPTION

The Games::Framework::RCP::Data module is a documentation module that
describes what uses the data based database tables and views.
Following PostGresQL schema organization, this module effectively
represents the data schema.

=head1 CONFIGURATION AND ENVIRONMENT

As this is a documentation module, no configuring is required.

=head1 TABLES

The four tables are listed below in alphabetical order:

=over

=item *

L</classes>

=item *

L</level_up>

=item *

L</starting_status>

=item *

L</status_effects>

=back

=head2 classes

=for html
<table>
	<caption>The list of the various classes.</caption>
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
			<td>id_job</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>AUTO_INCREMENT</td>
			<td>[pk]</td>
			<td>ID of the job.</td>
		</tr>
		<tr>
			<td>name</td>
			<td>varchar(32)</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[uniq]</td>
			<td>Name of the job.</td>
		</tr>
		<tr>
			<td>description</td>
			<td>varchar(256)</td>
			<td>NOT NULL</td>
			<td>'Fill me in with something!'</td>
			<td></td>
			<td>Description of the job.</td>
		</tr>
		<tr>
			<td>kind</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>1</td>
			<td></td>
			<td>Kind of job.  1 = normal.</td>
		</tr>
		<tr>
			<td>hp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>HP of the job.</td>
		</tr>
		<tr>
			<td>mp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>MP of the job.</td>
		</tr>
		<tr>
			<td>pp</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>PP of the job.</td>
		</tr>
		<tr>
			<td>spd</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>50</td>
			<td></td>
			<td>Speed of the job.</td>
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
	</tbody>
</table>

=begin text

Column          Type            Not Null    Default                     Constraints Comment
id_job          integer         NOT NULL    AUTO_INCREMENT              [pk]        ID of the job.
name            varchar(32)     NOT NULL                                [uniq]      secondary skillset
description     varchar(256)    NOT NULL   'Fill me in with something!'             auxillary skill
kind            integer         NOT NULL    1                                       Kind of job.  1 = normal.
hp              numeric(12,4)   NOT NULL    50                                      HP of the job.
mp              numeric(12,4)   NOT NULL    50                                      MP of the job.
pp              numeric(12,4)   NOT NULL    50                                      PP of the job.
spd             numeric(12,4)   NOT NULL    50                                      Speed of the job.
patk            numeric(12,4)   NOT NULL    50                                      Physical Attack
matk            numeric(12,4)   NOT NULL    50                                      Magical Attack
pdef            numeric(12,4)   NOT NULL    50                                      Physical Defense
mdef            numeric(12,4)   NOT NULL    50                                      Magical Defense
pacc            numeric(12,4)   NOT NULL    50                                      Physical Accuracy
macc            numeric(12,4)   NOT NULL    50                                      Magical Accuracy
pevd            numeric(12,4)   NOT NULL    50                                      Physical Evade
mevd            numeric(12,4)   NOT NULL    50                                      Magical Evade

=end text

The classes table shows all of the various classes that are
in use.  Each class has its own stats that make its use unique.

The kind column is there to restrict the classes that players
can play.  Game Masters can use any kind of class, mainly to
reprsent bosses.

For those that have seen
L<the combatants table|Games::Framework::RCP::Battle/combatants>,
they would notice that jobs here do not have max HP, MP, or PP.
A fighter's max of anything is determined by the HP, MP, or PP
set in this table.

=head2 level_up

=head2 fighter_status

=for html
<table>
	<caption>Stat boosts for leveled up jobs.</caption>
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
			<td>fkey_job</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk][pk]</td>
			<td>ID of the job.</td>
		</tr>
		<tr>
			<td>name</td>
			<td>varchar(4)</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk]</td>
			<td>Name of the stat to boost (must match column).</td>
		</tr>
		<tr>
			<td>value</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td></td>
			<td></td>
			<td>Value to boost per 1 level increase.</td>
		</tr>
	</tbody>
</table>

=begin text

Column      Type            Not Null    Default Constraints Comment
fkey_job    integer         NOT NULL            [fk][pk]    ID of the job.
name        varchar(4)      NOT NULL            [pk]        Name of the stat to boost (must match column).
value       numeric(12,4)   NOT NULL                        Value to boost per 1 level increase.

=end text

The level_up table shows the stat boosts each job
gets upon gaining one level.

When fighters join the battle, the number of levels they
have in that job determines the bonus stats applied for
that battle.  It is technically possible for fighters to
have fractional or even negative levels in a class.

All fighters start with level 0 in all classes.

=head2 starting_status

=for html
<table>
	<caption>What status effects do certain jobs start with?</caption>
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
			<td>fkey_job</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk][pk]</td>
			<td>ID of the job.</td>
		</tr>
		<tr>
			<td>name</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[fk][pk]</td>
			<td>ID of the status effect.</td>
		</tr>
		<tr>
			<td>length</td>
			<td>numeric(12,4)</td>
			<td>NOT NULL</td>
			<td>10000</td>
			<td></td>
			<td>Length of the effect.  -10K or less is indefinite: 10K or more is permament.</td>
		</tr>
	</tbody>
</table>

=begin text

Column      Type            Not Null    Default Constraints Comment
fkey_job    integer         NOT NULL            [fk][pk]    ID of the job.
fkey_status integer         NOT NULL            [fk][pk]    ID of the status effect.
length      numeric(12,4)   NOT NULL    10000               Length of the effect.  -10K or less is indefinite: 10K or more is permament.

=end text

The starting_status table shows what status effects
are to be applied to a particular job upon joining
the battle.  Usually, these status effects are permament,
hence the default value of 10000 for the length.

For the actual list of status effects,
L<see below|/"status_effects">.

=head2 status_effects

=for html
<table>
	<caption>List of status effects.</caption>
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
			<td>id_status</td>
			<td>integer</td>
			<td>NOT NULL</td>
			<td>AUTO_INCREMENT</td>
			<td>[pk]</td>
			<td>ID of the status effect.</td>
		</tr>
		<tr>
			<td>name</td>
			<td>varchar(32)</td>
			<td>NOT NULL</td>
			<td></td>
			<td>[uniq]</td>
			<td>Name of the status effect.</td>
		</tr>
		<tr>
			<td>desc</td>
			<td>varchar(100)</td>
			<td>NOT NULL</td>
			<td></td>
			<td></td>
			<td>Description of the status effect.</td>
		</tr>
		<tr>
			<td>is_good</td>
			<td>boolean</td>
			<td></td>
			<td></td>
			<td></td>
			<td>NULL = neutral effect.</td>
		</tr>
		<tr>
			<td>is_secret</td>
			<td>boolean</td>
			<td>NOT NULL</td>
			<td>false</td>
			<td></td>
			<td>Is this status effect traditionally hidden from players?</td>
		</tr>
	</tbody>
</table>

=begin text

Column      Type            Not Null    Default         Constraints Comment
id_status   integer         NOT NULL    AUTO_INCREMENT  [pk]        ID of the status effect.
name        varchar(32)     NOT NULL                    [uniq]      Name of the status effect.
desc        varchar(100)    NOT NULL                                Description of the status effect.
is_good     boolean                                                 NULL = neutral effect.
is_secret   boolean         NOT NULL    false                       Is this status effect traditionally hidden from players?

=end text

The status_effects table contains a listing of all of
the status effects in the game.  The effects are generally
grouped by if they are good effects, bad effects, or something
else entirely.

The current list of planned status effects are below,
grouped by want-ability and alphabetically arranged:

=over 4

=item Good status effects

=over 8

=item *

B<Deathshield> - Instant death attacks can't hurt you...most of the time.

=item *

B<Haste> - Every tick, you move closer to your turn than your teammates.

=item *

B<Quick> - Move so fast, one can take TWO actions per turn!

=item *

B<Regen> - Gradually recover a percentage of your health every so often.

=item *

B<Safeguard> - Protection from status ailments is great...when it works.

=back

=item Bad status effects

=over 8

=item *

B<Critial> - You are in danger of dying!  Watch your health!

=item *

B<Frozen> - You are stopped cold!  Fire melts you, but heavy damage KOs you!

=item *

B<KO> - You are knocked out.  Tough luck.

=item *

B<Petrify> - Almost nothing can affect you.  You are considered defeated until you recover.

=item *

B<Poison> - Every so often, those poisoned take a percentage of their max HP in damage.

=item *

B<Seizure> Lose some HP each tick.>

=item *

B<Slow> - Each tick, you move a fraction of your speed slower than your teammates.

=item *

B<Stop> - CT is frozen.  You can't move or do anything.

=item *

B<Undead> - Healing is bad for you: watch out for cure spells!

=back

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
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Data>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Data


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Data>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Data>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Data>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Data/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
