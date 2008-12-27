# $Revision: 0.07 $
# $Date: Sat Dec 27 17:00:00 2008 -0500 $
# $Source: lib/Games/Framework/RCP/Utilities/Colors.pm $

package Games::Framework::RCP::Utilities::Colors;

use 5.010;

use warnings;
use strict;
use utf8;

use Scalar::Util::Numeric qw(isint);

use Games::Framework::RCP::Database;

our $VERSION = '0.07';

sub insert_color_combo {
    my ( $fg,  $bg )  = @_;
    
    unless (isint($fg) and isint($bg))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "Both fg and bg variables must be an integer!  You supplied: $fg | $bg"
        );
    }
    
    if (defined select_id_by_color_combo( $fg, $bg ))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Unique->throw
        (
            error => "An ID already exists for the color variables provided!"
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();
    
    $sql = 'INSERT INTO utilities.colors (fg, bg) VALUES (?, ?)';
    $sth = $dbh->prepare($sql);
    $sth->execute( $fg, $bg );
    return 1;
}

sub update_color_combo {
    my ( $id, $fg, $bg ) = @_;
    
    unless (isint($id) and isint($fg) and isint($bg))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "The varibales id, fg and bg must be integers!  You supplied: $id | $fg | $bg"
        );
    }
    
    if (defined select_id_by_color_combo( $fg, $bg ))
    {
        Games::Framework::RCP::Exceptions::Database::Non_Unique->throw
        (
            error => "An ID already exists for the color variables provided!"
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();
    
    $sql = 'UPDATE utilities.colors SET fg = ?, bg = ? WHERE id_color = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $fg, $bg, $id );
    return 1;
}

sub delete_color_combo {
    my ($id) = @_;
    
    unless (isint($id))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "The id variable must be an integer!  You supplied: $id"
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'DELETE FROM utilities.colors WHERE id_color = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);
    return 1;
}

sub select_color_combo_by_id {
    my ($id) = @_;
    
    unless (isint($id))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "The id variable must be an integer!  You supplied: $id"
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT fg, bg FROM utilities.colors WHERE id_color = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute($id);

    while ( my $row = $sth->fetchrow_hashref() ) {
        return { fg => $row->{fg}, bg => $row->{bg} };
    }
    return;
}

sub select_id_by_color_combo {
    my ( $fg,  $bg )  = @_;
    
    unless (isint($fg) and isint($bg))
    {
        Games::Framework::RCP::Exceptions::Database::Invalid_Type->throw
        (
            error => "Both fg and bg variables must be an integer!  You supplied: $fg | $bg"
        );
    }
    
    my ( $sql, $sth ) = undef;
    my $dbh = Games::Framework::RCP::Database->instance();

    $sql = 'SELECT id_color FROM utilities.colors WHERE fg = ? AND bg = ?';
    $sth = $dbh->prepare($sql);
    $sth->execute( $fg, $bg );

    while ( my $row = $sth->fetchrow_hashref() ) {
        return $row->{id_color};
    }
    return;
}

1;

__END__

=head1 DISCLAIMER

This software is currently under development.  It is not done.
While it will not be done quickly, contributions can help
make things go faster.  Please contribute if you can.

=head1 NAME

Games::Framework::RCP::Utilities::Colors - Subroutines for the colors Table.

=head1 VERSION

Version 0.07

=head1 DEPENDENCIES

The requirements for this module are as follows:

=over 4

=item *

Perl 5.10 or higher

=item *

L<DBI|DBI>

=item *

L<Games::Framework::RCP::Database|Games::Framework::RCP::Database>

=back

=head1 SYNOPSIS

 use Games::Framework::RCP::Utilities::Colors;
 my $id = 1;
 my $color_pair = Games::Framework::RCP::Utilities::Colors::select_color_combo_by_id($id);

=head1 DESCRIPTION

This module contains various functions used to manipulate the colors table.
The colors themselves are based off of IRC: See L<the note below|/"COLOR BACKGROUND">.
One can insert, delete, update, and select various foreground and background
color pairs.  Note that it is recommended to not delete the particular
pairs.

=head1 CONFIGURATION AND ENVIRONMENT

No configuration should be required.

=head1 COLOR BACKGROUND

The inspiration for the colors table comes from IRC, as this application
is based off of an mIRC application that others have used in the past
(see L<the acknowledgements|/ACKNOWLEDGEMENTS>).  There are sixteen
possible colors to use, and therefore 256 combinations of both a foreground
and background.  The colors themselves are generally listed in this
order:

=over 4

=item *

White

=item *

Black

=item *

Blue

=item *

Green

=item *

Light Red

=item *

Brown

=item *

Purple

=item *

Orange

=item *

Yellow

=item *

Light Green

=item *

Cyan

=item *

Light Cyan

=item *

Light Blue

=item *

Pink

=item *

Gray

=item *

Light Gray

=back

There are subroutines included below that can translate the IRC color
codes to both their actual color names, and the RGB hex equivalent.
If more color combinations are added, then the functions below may
not recognize them unless hacked in.

As a forewarning, it is NOT recommended to store every possible
color combination inside the colors table.  Even if you change the
ID to use a big integer and the other columns to ints, the math...
well, let's break it down, shall we?

There are 1000000 colors using hexadecimal.  Squaring that gives
1000000000000 hex, or 2^48 in decimal.  Storage requires 8 bytes
for the ID, 4 bytes for the foreground, and 4 bytes for the
background, so multiplying 2^48 * 16 = 2^52 bytes.  How many bytes
is that exactly?  Well, take a look below:

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

Needless to say, keep the colors you use for your
home game in moderation. ☺

=head1 SUBROUTINES/METHODS

=head2 insert_color_combo

This function is used to insert a new color combination.

The parameters are as follows:

=over 4

=item * $_[0]

the decimal number of the foreground color.

=item * $_[1]

the decimal number of the background color.

=back

=head2 update_color_combo

This function takes a color ID and replaces the colors currently
assigned to it with the two decimal colors supplied.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the color pair.

=item * $_[1]

the new foreground color.

=item * $_[2]

the new background color.

=back

=head2 delete_color_combo

This function removes a color combo based off of its ID.
It is recommended to NEVER call this function: however, it
is provided just in case someone wants to have fun with it.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the color pair.

=back

=head2 select_color_combo_by_id

This function is provided standalone should one ever want
to get a color combo associated with an ID.

The parameters are as follows:

=over 4

=item * $_[0]

the ID of the color pair.

=back

Return the foreground/background color pair if it's found.

=head2 select_id_by_color_combo

This function is provided standalone should one ever want
to get an ID associated with a color combo.

The parameters are as follows:

=over 4

=item * $_[0]

the decimal foreground color.

=item * $_[1]

the decimal background color.

=back

Return the ID of the color pair if it's found.

=head1 INCOMPATIBILITIES

There are no known incompatibilities in this module.

=head1 DIAGNOSTICS

There are no known problems, and therefore no need to provide solutions.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Utilities-Colors>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Utilities::Colors


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Utilities-Colors>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Utilities-Colors>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Utilities-Colors>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Utilities-Colors/>

=back

=head1 ACKNOWLEDGEMENTS

Major thanks must be given to the Freenode Perl channel for pointing
out the futility of storing every single color combination in a database.

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all other acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2008 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
