#!/usr/local/bin/perl -w

use strict ;

use Carp ;
use Test::More ;

BEGIN{
    plan( tests => 2 ) ;
	use_ok( 'File::Slurp' ) ; # first test
}

my $proc_file = "/proc/$$/auxv" ;

SKIP: {

	unless ( -r $proc_file ) {

		skip "can't find pseudo file $proc_file", 1 ; # second test
	}

	test_pseudo_file() ; # second test
}

sub test_pseudo_file {

	my $data_do = do{ local( @ARGV, $/ ) = $proc_file; <> } ;

	my $data_slurp = read_file( $proc_file ) ;

	is( $data_do, $data_slurp, 'pseudo' ) ;
}
