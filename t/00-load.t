#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Test::Mock::AllTestsOk' );
}

diag( "Testing Test::Mock::AllTestsOk $Test::Mock::AllTestsOk::VERSION, Perl $], $^X" );
