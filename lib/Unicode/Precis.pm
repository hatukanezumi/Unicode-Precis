#-*- perl -*-
#-*- coding: utf-8 -*-

package Unicode::Precis;

use 5.008007;    # Use Unicode 4.1.0 or later.
use strict;
use warnings;

BEGIN { die 'Can\'t use ' . __PACKAGE__ unless pack('U', 0x0041) eq 'A'; }
use Encode qw(is_utf8 _utf8_on _utf8_off);
use Unicode::BiDiRule qw(check);
use Unicode::Normalize qw(normalize);
use Unicode::Precis::Preparation qw(prepare FreeFormClass IdentifierClass);
use Unicode::Precis::Utils;

our $VERSION    = '0.000_01';
$VERSION = eval $VERSION;    # see L<perlmodstyle>

sub new {
    my $class   = shift;
    my %options = @_;

    bless {%options} => $class;
}

sub enforce {
    my ($self, $string, %options) = @_;

    if (lc($self->{WidthMappingRule} || '') eq 'decomposition') {
        return unless defined Unicode::Precis::Utils::decomposeWidth($string);
    }
    if (lc($self->{AdditionalMappingRule} || '') eq 'space') {
        return unless defined Unicode::Precis::Utils::mapSpace($string);
    }
    if (lc($self->{CaseMappingRule} || '') eq 'fold') {
        return unless defined Unicode::Precis::Utils::foldCase($string);
    }
    if ($self->{NormalizationRule}) {
        if (is_utf8($string)) {
            $string =
                eval { normalize(uc $self->{NormalizationRule}, $string) };
        } else {
            _utf8_on($string);
            $string =
                eval { normalize(uc $self->{NormalizationRule}, $string) };
            _utf8_off($string);
        }
        return unless defined $string;
    }
    if (ref $self->{ASCIIRule} eq 'CODE' and $string !~ /[^\x20-\x7E]/) {
	return unless defined ($string = $self->{ASCIIRule}->($string));
    } else {
	if (lc($self->{DirectionalityRule} || '') eq 'bidi') {
            return unless defined check($string);
        }
        my $stringclass = {
            freeformclass   => FreeFormClass,
            identifierclass => IdentifierClass,
        }->{lc($self->{StringClass} || '')} || 0;
        return
	    unless defined prepare($string, $stringclass);
    }
    if (ref $self->{OtherRule} eq 'CODE') {
        return
            unless defined($string = $self->{OtherRule}->($string));
    }

    $_[1] = $string;
}

1;
__END__

=encoding utf-8

=head1 NAME

Unicode::Precis - RFC 7564 PRECIS Framework - Enforcement

=head1 SYNOPSIS

  use Unicode::Precis;
  $precis = Unicode::Precis->new(options...);
  $string = $precis->enforce($input);

=head1 DESCRIPTION

L<Unicode::Precis> performs enforcement of
UTF-8 bytestring or Unicode string according to PRECIS Framework.

Note that bytestring will not be upgraded but treated as UTF-8 sequence
by this module.

=head2 Methods

=over

=item new ( options ... )

I<Constructor>.
Creates new instance of L<Unicode::Precis>.
Following options may be specified.

=over

=item WidthMappingRule =E<gt> 'Decomposition'

If specified, maps fullwidth and halfwidth characters to their decomposition
mappings
using decomposeWidth().

=item AdditionalMappingRule =E<gt> 'Space'

If specified, maps non-ASCII space characters to ASCII space
using mapSpace().

=item CaseMappingRule =E<gt> 'Fold'

If specified, maps uppercase and titlecase characters to lowercase
using foldCase().

=item NormalizationRule =E<gt> 'NFC' | 'NFKC' | 'NFD' | 'NFKD'

If specified, normalizes string using given normalization form.

=item LDHRule =E<gt> $subref

If specified and $string consists only of US-ASCII graphic characters,
replaces string with the result of subroutine referred by $subref, and
DirectionalityRule (see below) is not applied.

=item DirectionalityRule =E<gt> 'BiDi'

If specifiled, checks string against BiDi Rule.

=item StringClass =E<gt> 'FreeFormClass' | 'IdentifierClass'

If specified, checks string according to given string class.

=item OtherRule =E<gt> $subref

If specified, replaces string with the result of subroutine referred by
$subref.

=back

=item enforce ( $string, [ Replacement =E<gt> $replacement ] )

I<Instance method>.
Performs enforcement on the string.
If processing succeeded, modifys $string and returns it.
Otherwise returns C<undef>.

=back

=head2 Exports

None are exported.

=head1 CAVEATS

The repertoire this module can handle is restricted by Unicode database
of Perl core: Characters beyond it are considered to be "unassigned"
and are disallowed, even if they are available by recent version of
Unicode.  Table below lists implemented Unicode version by each Perl version.

  Perl's version     Implemented Unicode version
  ------------------ ---------------------------
  5.8.7, 5.8.8       4.1.0
  5.10.0             5.0.0
  5.8.9, 5.10.1      5.1.0
  5.12.x             5.2.0
  5.14.x             6.0.0
  5.16.x             6.1.0
  5.18.x             6.2.0
  5.20.x             6.3.0

=head1 RESTRICTIONS

This module does not support EBCDIC platforms.

=head1 SEE ALSO

RFC 7564 I<PRECIS Framework: Preparation, Enforcement, and Comparison of
Internationalized Strings in Application Protocols>.
L<https://tools.ietf.org/html/rfc7564>.

L<Unicode::BiDiRule>, L<Unicode::Normalize>, L<Unicode::Precis::Preparation>.

=head1 AUTHOR

Hatuka*nezumi - IKEDA Soji, E<lt>hatuka@nezumi.nuE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Hatuka*nezumi - IKEDA Soji

This library is free software; you can redistribute it and/or modify it
under the same terms as Perl itself. For more details, see the full text of
the licenses at <http://dev.perl.org/licenses/>.

This program is distributed in the hope that it will be
useful, but without any warranty; without even the implied
warranty of merchantability or fitness for a particular purpose.

=cut
