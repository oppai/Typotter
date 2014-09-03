use strict;
use warnings;

use Test::More;

BEGIN {
    use_ok('Typotter');
}

subtest '__marge_table' => sub {
    pass;
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

done_testing;
__END__
