package Test::Mock::AllTestsOk;

use 5.006001;

$VERSION = 0.01;

use strict;
use warnings;

use Carp;
use Scalar::Util 1.11 'set_prototype';
use Symbol qw/ qualify_to_ref qualify /;

my %mocks = (
             "Test::More" => {
                              proto_S_S  => [qw( ok )],
                              proto_SS_S => [qw( is )],
                             },
            );

# the only difference is the prototype so we prepare a dummy per prototype
sub proto_S_S  ($;$)  { my( undef, $name )        = @_; my $tb = Test::More->builder; return $tb->ok( 1, $name ); }
sub proto_SS_S ($$;$) { my( undef, undef, $name ) = @_; my $tb = Test::More->builder; return $tb->ok( 1, $name ); }

CHECK {
        no strict "refs";

        for my $module (keys %mocks) {
                for my $mocksub (keys %{$mocks{$module}}) {
                        for my $sub (@{$mocks{$module}{$mocksub}}) {
                                my $glob      = qualify_to_ref($sub => $module);
                                my $mocksub_proto = set_prototype(sub { &{$mocksub} }, prototype \&$glob);
                                {
                                        no warnings 'redefine';
                                        *{$module."::".$sub} = $mocksub_proto;
                                        *{"main" ."::".$sub} = $mocksub_proto if *{"main" ."::".$sub};
                                }
                        }
                }
        }
}

1;

__END__

=head1 NAME

Test::Mock::AllTestsOk - Mock all testcode to do nothing.

=head1 ABOUT

This module mocks all typical test function from modules

  Test::More
  Test::Most
  Test::Deep

to always return ok. In particular this means their test functionality
is skipped, so the overhead of the tests is dropped and reduced to
only the function call overhead.

You can use this to benchmark distribution by running the code from
their test suites without the test overhead itself.

=head1 SYNOPSIS

The module executes mocking during load so you only need to use the
module like this:

    perl -MTest::Mock::AllTestsOk `which prove` t/*.t

=head1 AUTHOR

Steffen Schwigon, C<< <ss5 at renormalist.net> >>

=head1 BUGS

Please report any bugs or feature requests to
C<bug-test-mock-alltestsok at rt.cpan.org>, or through the web
interface at
L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Test-Mock-AllTestsOk>.
I will be notified, and then you'll automatically be notified of
progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Test::Mock::AllTestsOk


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Test-Mock-AllTestsOk>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Test-Mock-AllTestsOk>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Test-Mock-AllTestsOk>

=item * Search CPAN

L<http://search.cpan.org/dist/Test-Mock-AllTestsOk/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 COPYRIGHT & LICENSE

Copyright 2010 Steffen Schwigon, all rights reserved.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.
