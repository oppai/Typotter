use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Typotter');
}

subtest '__parse_line' => sub {
    my $line = '%hoge !@foo_hoge = foo; "huga" $hoge';
    my $expected_table = {
        hoge => 3,
        foo  => 2,
        huga => 1,
    };
    my $result = Typotter::__parse_line($line);
    is_deeply $expected_table, $result,'detect word';
};

subtest '__merge_table' => sub {
    my $a_table = {
        hoge => 1,
        foo  => 2,
    };
    my $b_table = {
        hoge => 2,
        huga => 1,
    };
    my $expected_table = {
        hoge => 3,
        foo  => 2,
        huga => 1,
    };

    my $result = Typotter::__merge_table($a_table,$b_table);
    is_deeply $expected_table, $result,'merge and sort'
};


subtest '__write_dict' => sub {
    my $table = {
        hoge => 3,
        foo  => 2,
        huga => 1,
    };
    my $result = Typotter::__write_dict('/tmp/typotter_sample.dict',$table);
    ok $result;
};

subtest '__read_dict' => sub {
    my $result = Typotter::__read_dict('/tmp/typotter_sample.dict');
    is scalar keys $result,3, "three words";
};

done_testing;
__END__
