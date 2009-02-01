package Games::Framework::RCP::Database::Result::VarStr;

use strict;
use warnings;

our $VERSION = '0.22';

use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/UTF8Columns Core/);
__PACKAGE__->table('vars_str');
__PACKAGE__->add_columns(
    id_variable => {
        data_type => 'integer',
        is_nullable => 0,
        is_auto_increment => 1,
        comments => 'ID of the variable.',
        extra => {unsigned => 1},
    },
    name => {
        data_type => 'varchar',
        size => 64,
        is_nullable => 0,
        comments => 'Name of the variable.',
    },
    value => {
        data_type => 'varchar',
        size => 64,
        is_nullable => 0,
        comments => 'Value of the variable.',
    },
);

__PACKAGE__->utf8_columns(qw/name value/);
__PACKAGE__->set_primary_key('id_variable');
__PACKAGE__->add_unique_constraint(['name']);

sub sqlt_deploy_hook {
    my ($self, $sqlt_table) = @_;
    
    $sqlt_table->options({ENGINE => 'InnoDB'});
    $sqlt_table->options({CHARSET => 'UTF8'});
    $sqlt_table->comments('List of string variables.');
}

1;

__END__

=head1 NAME

Games::Framework::RCP::Database::Result::VarStr - List of string variables.

=head1 VERSION

0.22

=head1 DESCRIPTION

The vars str table contains a list of string variables, or
flags, that Game Masters may wish to toggle at certain points
during the battle.  Each variable offers different effects.

Note that this table requires the use of a driver program in
order to be effective.

=head1 DATABASE TABLE

List of string variables.

=head2 id_variable

This is the primary key of the table,
using the traditional auto incrementing.

=head2 name

This accepts 64 characters to identify a variable name.
Needless to say, these must be unique.

=head2 value

This is the value of the given variable name.

=head1 SUBROUTINES/METHODS

=head2 sqlt_deploy_hook()

sqlt_deploy_hook is used to define the table settings
for the various databases.

=head1 AUTHOR

Jason Felds, C<< <wolfman.ncsu2000 at gmail.com> >>

=head1 BUGS AND LIMITATIONS

Please report any bugs or feature requests to C<bug-Games-Framework-RCP at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Games-Framework-RCP-Database-Result-VarStr>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Games::Framework::RCP::Database::Result::VarStr


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Games-Framework-RCP-Database-Result-VarStr>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Games-Framework-RCP-Database-Result-VarStr>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Games-Framework-RCP-Database-Result-VarStr>

=item * Search CPAN

L<http://search.cpan.org/dist/Games-Framework-RCP-Database-Result-VarStr/>

=back

=head1 ACKNOWLEDGEMENTS

See L<Games::Framework::RCP|Games::Framework::RCP/ACKNOWLEDGEMENTS>
for all acknowledgements.

=head1 LICENSE AND COPYRIGHT

Copyright 2009 Jason Felds, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.