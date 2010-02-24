#! /usr/bin/env perl


use strict;
use warnings;
use Test::More tests => 8;

TODO: {
        local $TODO = "We will we will mock you!";

        # ok
        ok(0, "Test One being not ok or mocked ok");
        Test::More::ok(0, "Test Two being not ok or mocked ok");
        ok(0);
        Test::More::ok(0);

        # is
        is("a", "b", "Test Five being not ok or mocked ok");
        Test::More::is("a", "b", "Test Six being not ok or mocked ok");
        is("a", "b");
        Test::More::is("a", "b");

}
