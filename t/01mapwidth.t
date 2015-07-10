#-*- perl -*-
#-*- coding: utf-8 -*-

use strict;
use warnings;
no utf8;

use Encode qw(_utf8_on);
use Test::More tests => 1;
use Unicode::Precis;

my $precis = Unicode::Precis->new(
    WidthMappingRule => 'Decomposition',
);
my $string = "イロハｲﾛﾊABCＡＢＣ";
is($precis->enforce($string), "イロハイロハABCABC");

