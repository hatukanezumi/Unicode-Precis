#-*- perl -*-
#-*- coding: utf-8 -*-

use strict;
use warnings;
no utf8;

use Test::More tests => 2;
use Unicode::Precis::Utils qw(lowerCase);

my %data = map {
    my $s = $_;
    1 while chomp $s;
    $s
} do { local $/ = ''; <DATA> };

while (my($text, $lower) = each %data) {
    lowerCase($text);
    is($text, $lower, $lower);
}

__END__
 tHe QUIcK bRoWn

 the quick brown

aBIΣßΣ/񟿿𐐅

abiσßσ/񟿿𐐭

