use strict;
use warnings;

use Test::More;
use Test::MockModule;
use Test::MockObject;

BEGIN {
    use_ok('Typotter::Dictionary::Util');
}

subtest 'parse_line' => sub {
    my $expected_table = {
        hoge => 3,
        foo  => 3,
        test => 3,
    };
    my $result = Typotter::Dictionary::Util::parse_file('t/resource/sample_file/sample1.txt');
    is_deeply $expected_table, $result,'detect word from file';
};

subtest 'parse_line' => sub {
    my $line = '%hoge !@foo_hoge = foo; "huga" $hoge';
    my $expected_table = {
        hoge => 3,
        foo  => 2,
        huga => 1,
    };
    my $result = Typotter::Dictionary::Util::parse_line($line);
    is_deeply $expected_table, $result,'detect word';
};

subtest 'merge_table' => sub {
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

    my $result = Typotter::Dictionary::Util::merge_table($a_table,$b_table);
    is_deeply $expected_table, $result,'merge and sort'
};


subtest 'write_dict' => sub {
    my $table = {
        hoge => 3,
        foo  => 2,
        huga => 1,
    };
    my $result = Typotter::Dictionary::Util::write_dict('/tmp/typotter_sample.dict',$table);
    ok $result;
};

subtest 'read_dict' => sub {
    my $result = Typotter::Dictionary::Util::read_dict('/tmp/typotter_sample.dict');
    is scalar keys $result,3, "three words";
};

done_testing;
__END__
