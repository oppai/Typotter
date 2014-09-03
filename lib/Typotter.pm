package Typotter;
use 5.008005;
use strict;
use warnings;

use IO::File;
use List::MoreUtils qw(zip);

our $VERSION = "0.01";

sub run {
    my ($class,$args) = @_;
    # make dictionary
    __run_parser($args->{file_path}) if defined $args->{file_path};
}

sub __run_parser {
    my $file_path = shift;
    my $file_handler = IO::File->new($file_path, "r");
    my $table = {};
    while(my $line = $file_handler->getline ){
        $table = __merge_table( $table, __parse_line($line) );
    };
    $file_handler->close;

    return $table;
}

sub __parse_line {
    my $line = shift;
    my $table = {};
    for my $word ( $line =~ m/([a-zA-Z]{3,})/g ) {
        $table->{$word} += 1; 
    }
    return __sort_table($table);
}

sub __merge_table {
    my ($src,$dst) = @_;
    my $result = {};

    my @s_key = keys $src;
    my @d_key = keys $dst;

    for my $key ( zip @s_key, @d_key ){
        $result->{$key} = __hash_value($src,$key) + __hash_value($dst,$key) if $key;
    }
    return $result;
}

sub __hash_value {
    my ($hashref,$key) = @_;
    return exists $hashref->{$key} ? $hashref->{$key} : 0;
}

sub __sort_table {
    my $table = shift;
    return { map {
        $_ => $table->{$_}
    } sort {
        $table->{$a} > $table->{$b}
    } keys $table }
}

sub __write_dict {
    my ($file_path,$table) = @_;
    my $file_handler = IO::File->new($file_path, "w");
    return unless $file_handler;

    for my $key ( sort { $table->{$a} < $table->{$b} } keys $table ) {
        print $file_handler "$key,$table->{$key}\n";
    };
    $file_handler->close;
    return 1;
}

sub __read_dict {
    my $file_path = shift;
    my $file_handler = IO::File->new($file_path, "r");
    my $table = {};
    return unless $file_handler;

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

=encoding utf-8

=head1 NAME

Typotter - It's new $module

=head1 SYNOPSIS

    use Typotter;

=head1 DESCRIPTION

Typotter is ...

=head1 LICENSE

Copyright (C) kodam.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

kodam E<lt>hotsoup.h@gmail.comE<gt>

=cut

