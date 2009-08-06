#!/usr/local/bin/perl -w

use strict ;
use Carp ;
use Test::More ;

my @tests = ( map {[sprintf('0%o', $_), $_]} 0644, 0755 );

plan tests => 1+@tests;
use_ok( 'File::Slurp' ) ;

for (@tests) {
    my ($text_mode, $mode) = @$_;
    my $file = "chmod-$text_mode";

    write_file( $file, {chmod=>$mode}, "test text $text_mode" );

    my $fmode = (stat $file)[2];
       $fmode &= 0777; # we're only interested in the lower three bits
       $fmode = sprintf( '0%o', $fmode ); # and the text flavor of it

    is( $fmode, $text_mode, $file );

    unlink $file ;
}
