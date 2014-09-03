package Typotter;
use 5.008005;
use strict;
use warnings;

use IO::File;
use List::MoreUtils qw(zip);

our $VERSION = "0.01";

sub run {
    my ($class,$args) = @_;
    __run_parser($args->{file_path});
}

sub __run_parser {
    my $file_path = shift;
    my $file_handler = IO::File->new($file_path, "r");
    while(my $line = $file_handler->getline ){
        __parse_line($line);
    };
    $file_handler->close;
}

sub __parse_line {
    my $line = shift;
    my $table = {};
    for my $word ( $line =~ m/([a-zA-Z]{3,})/g ) {
        $table->{$word} += 1; 
    }
    use Data::Dumper;
    warn Dumper $table;
    return $table;
}

sub __merge_table {
    my ($src,$dst) = @_;
    my $result = {};

    my @s_key = keys $src;
    my @d_key = keys $dst;

    for my $key ( zip @s_key, @d_key ){
        $result->{$key} = $src->{$key} + $dst->{$key};
    }

    return { map {
        $_ => $result->{$_}
    } sort {
        $result->{$a} > $result->{$b}
    } keys $result };
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

