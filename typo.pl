use strict;
use warnings;

use Typotter::Dictionary;

use Data::Dumper;
warn Dumper( Typotter::Dictionary->create({file_path => $ARGV[0]}) );



__END__
=head1 NAME

word_table.pl

=head1 SYNOPSIS

./word_table.pl [options] [file ...]

 Options:
   -help            brief help message
   -man             full documentation

=head1 OPTIONS

=over 4

=item B<-help>

Print a brief help message and exits.

=item B<-man>

Prints the manual page and exits.

=back

=head1 DESCRIPTION

B<This program> will read the given input file(s) and do something
useful with the contents thereof.

=cut
