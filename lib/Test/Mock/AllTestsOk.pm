package Test::Mock::AllTestsOk;

use 5.006001;

$VERSION = 0.01;

use strict;
use warnings;

use Carp;
use Scalar::Util 1.11 'set_prototype';
use Symbol qw/ qualify_to_ref qualify /;

my %mocks = (
             "Test::More" => [ qw( ok ) ],
            );

sub ok ($;$) {
        my( $test, $name ) = @_;
        my $tb = Test::More->builder;
        return $tb->ok( 1, $name );
}

CHECK {
        no strict "refs";

        foreach my $module (keys %mocks) {
                foreach my $sub (@{$mocks{$module}}) {
                        my $glob = qualify_to_ref($sub => $module);
                        my $mock = set_prototype(sub { &{$sub} }, prototype \&$glob);
                        {
                                no warnings 'redefine';
                                *{$module."::".$sub} = $mock;
                                *{"main::".$sub}     = $mock; # TODO: do this only for imported/existing subs
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
