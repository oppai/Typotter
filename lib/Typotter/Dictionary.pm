package Typotter::Dictionary;
use 5.008005;
use strict;
use warnings;

use Typotter::Dictionary::Util qw/
    parse_file
    read_dict
    write_dict
    merge_table
    sort_table
/;

sub create {
    my ($class,$args) = @_;
    return unless $args->{file_path};
    my $dict_path = $args->{output_path} // '/tmp/typotter.dict';
    my $table = read_dict($dict_path);

    $table = merge_table( $table, parse_file($args->{file_path}));
    write_dict($dict_path,$table);
    return sort_table($table);
}

1;
