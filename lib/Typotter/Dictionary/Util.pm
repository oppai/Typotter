package Typotter::Dictionary::Util;
use 5.008005;
use strict;
use warnings;

use parent qw/Exporter/;

use IO::File;
use List::MoreUtils qw(zip);

our @EXPORT = qw/
    parse_file parse_line
    merge_table hash_value sort_table
    write_dict read_dict
/;

sub parse_file {
    my $file_path = shift;
    my $file_handler = IO::File->new($file_path, "r");
    my $table = {};
    while(my $line = $file_handler->getline ){
        $table = merge_table( $table, parse_line($line) );
    };
    $file_handler->close;

    return $table;
}

sub parse_line {
    my $line = shift;
    my $table = {};
    for my $word ( $line =~ m/([a-zA-Z]{3,})/g ) {
        $table->{$word} += 1; 
    }
    return $table;
}

sub merge_table {
    my ($src,$dst) = @_;
    my $result = {};

    my @s_key = keys $src;
    my @d_key = keys $dst;

    for my $key ( zip @s_key, @d_key ){
        $result->{$key} = hash_value($src,$key) + hash_value($dst,$key) if $key;
    }
    return $result;
}

sub hash_value {
    my ($hashref,$key) = @_;
    return exists $hashref->{$key} ? $hashref->{$key} : 0;
}

sub sort_table {
    my $table = shift;
    return { map {
        $_ => $table->{$_}
    } sort {
        $table->{$b} <=> $table->{$a}
    } keys $table }
}

sub write_dict {
    my ($file_path,$table) = @_;
    my $file_handler = IO::File->new($file_path, "w");
    return unless $file_handler;

    for my $key ( sort { $table->{$b} <=> $table->{$a} } keys $table ) {
        print $file_handler "$key,$table->{$key}\n";
    };
    $file_handler->close;
    return 1;
}

sub read_dict {
    my $file_path = shift;
    my $file_handler = IO::File->new($file_path, "r");
    return {} unless $file_handler;

    my $table = {};
    while(my $line = $file_handler->getline ){
        chomp $line;
        my @col = split ",",$line;
        $table->{$col[0]} = $col[1];
    };
    $file_handler->close;

    return $table;
}


1;
__END__

