use strict;
use warnings;

use Test::More;
use Test::MockModule;

BEGIN {
    use_ok('Typotter::Dictionary');
}

subtest 'create' => sub {
    my $mock = Test::MockModule->new('Typotter::Dictionary');
    $mock->mock('write_dict' => sub { return {}; });
    $mock->mock('read_dict' => sub { return {}; });
    my $expected_table = {
        hoge => 3,
        foo  => 3,
        test => 3,
    };
    my $result = Typotter::Dictionary->create({file_path => 't/resource/sample_file/sample1.txt'});
    is_deeply $expected_table,$result;
};

done_testing;
