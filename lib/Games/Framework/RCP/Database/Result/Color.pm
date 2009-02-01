package Games::Framework::RCP::Database::Result::Color;

use strict;
use warnings;
use utf8;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/Core/);
__PACKAGE__->table('colors');
__PACKAGE__->add_columns(
    id_color => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the color.',
        extra => {unsigned => 1},
    },
    fg => {
        data_type => 'varchar',
        size => 8,
        is_nullable => 0,
        comments => 'Foreground color.',
    },
    bg => {
        data_type => 'varchar',
        size => 8,
        is_nullable => 0,
        comments => 'Background color.',
    },
);
__PACKAGE__->set_primary_key('id_color');
__PACKAGE__->add_unique_constraint([qw/fg bg/]);

__PACKAGE__->might_have(move_type => 'Games::Framework::RCP::Database::Result::MoveType', 'fkey_color', {cascade_delete => 0});

__PACKAGE__->might_have(character => 'Games::Framework::RCP::Database::Result::Character', 'fkey_color', {cascade_delete => 0});

__PACKAGE__->might_have(status_effect => 'Games::Framework::RCP::Database::Result::StatusEffect', 'fkey_color', {cascade_delete => 0});

__PACKAGE__->might_have(currency => 'Games::Framework::RCP::Database::Result::Currency', 'fkey_color', {cascade_delete => 0});

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('The foreground/background color combinations.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::Color - The foreground/background color combinations.

=head1 VERSION

0.22

=head1 DESCRIPTION

The colors table allows a Game Master to give a class, move,
item, or almost anything else a foreground and background
color for variety.  The format is specifically left
unspecified: one can use mIRC colors, HTML colors,
or any other color system.  The only thing to be
careful of: do not try to store every color in the
universe.  Why is that?

Assuming HTML color format, there are 1000000 colors using hexadecimal.
Squaring that gives 1000000000000 hex, or 2^48 in decimal.
Storage requires 8 bytes for the ID, 4 bytes for the foreground,
and 4 bytes for the background, so multiplying 2^48 * 16 = 2^52 bytes.
How many bytes is that exactly?  Well, take a look below:

=for html
<table>
    <caption>Ways to represent 2<sup>52</sup>
    <thead><tr>
        <th>2<sup>x</sup></th>
        <th>Full Number</th>
        <th>Measurement</th>
    </tr></thead>
    <tr>
        <td>2<sup>52</sup></td>
        <td>4503599627370496</td>
        <td>bytes</td>
    </tr>
    <tr>
        <td>2<sup>42</sup></td>
        <td>4398046511104</td>
        <td>kilobytes</td>
    </tr>
    <tr>
        <td>2<sup>32</sup></td>
        <td>4294967296</td>
        <td>megabytes</td>
    </tr>
    <tr>
        <td>2<sup>22</sup></td>
        <td>4194304</td>
        <td>gigabytes</td>
    </tr>
    <tr>
        <td>2<sup>12</sup></td>
        <td>4096</td>
        <td>terabytes</td>
    </tr>
    <tr>
        <td>2<sup>2</sup></td>
        <td>4</td>
        <td>petabytes</td>
    </tr>
</table>

=begin text

Ways to represent 2^52

2^x     Full Number         Measurement
2^52    4503599627370496    bytes
2^42    4398046511104       kilobytes
2^32    4294967296          megabytes
2^22    4194304             gigabytes
2^12    4096                terabytes
2^2     4                   petabytes

=end text

=begin man

Ways to represent 2^52

2^x     Full Number         Measurement
2^52    4503599627370496    bytes
2^42    4398046511104       kilobytes
2^32    4294967296          megabytes
2^22    4194304             gigabytes
2^12    4096                terabytes
2^2     4                   petabytes

=end man

Needless to say, keep the colors you use for your
home game in moderation. ☺

=head1 DATABASE TABLE

The foreground/background color combinations.

=head2 id_color

This is the primary key of the table,
using the traditional auto incrementing.

=head2 fg

This is the foreground color.

=head2 bg

This is the background color.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-Color>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::Color


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-Color>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-Color>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-Color>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-Color/>

=back

=head1 ACKNOWLEDGEMENTS

Major thanks must be given to the Freenode Perl channel for pointing
out the futility of storing every single color combination in a database.

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all other acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.