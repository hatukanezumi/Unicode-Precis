#-*- perl -*-
#-*- coding: utf-8 -*-

package Unicode::Precis::Utils;

use 5.008001;
use strict;
use warnings;

our $VERSION    = '0.01';
our $XS_VERSION = $VERSION;
$VERSION = eval $VERSION;    # see L<perlmodstyle>

require XSLoader;
XSLoader::load(__PACKAGE__, $XS_VERSION);

1;
__END__

=encoding utf-8

=head1 NAME

Unicode::Precis::Utils - Utility functions for PRECIS enforcement

=head1 DESCRIPTION

TBD.

=head2 Functions

=over

=item foldCase ( $string )

Applys Unicode Default Case Folding to $string.
If processing succeeded, modifys $string and returns it.
Otherwise, returns C<undef>.

=item mapSpace ( $string )

Maps non-ASCII spaces (those in general category Zs) to SPACE (U+0020).
If processing succeeded, modifys $string and returns it.
Otherwise, returns C<undef>.

=item decomposeWidth ( $string )

Maps fullwidth and halfwidth characters in $string to their decomposition
mappings.
If processing succeeded, modifys $string and returns it.
Otherwise, returns C<undef>.

=back

=head1 SEE ALSO

L<Unicode::Precis>.

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

