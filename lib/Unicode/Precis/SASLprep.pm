#-*- perl -*-
#-*- coding: utf-8 -*-

use strict;
use warnings;

package Unicode::Precis::UsernameCaseMapped;
{
    use base qw(Unicode::Precis);

    sub new {
        bless shift->SUPER::new(
            WidthMappingRule   => 'Decomposition',
            CaseMappingRule    => 'Fold',
            NormalizationRule  => 'NFC',
            DirectionalityRule => 'BiDi',
            StringClass        => 'IdentifierClass',
        );
    }
}

package Unicode::Precis::UsernameCasePreserved;
{
    use base qw(Unicode::Precis);

    sub new {
        bless shift->SUPER::new(
            WidthMappingRule   => 'Decomposition',
            NormalizationRule  => 'NFC',
            DirectionalityRule => 'BiDi',
            StringClass        => 'IdentifierClass',
        );
    }
}

package Unicode::Precis::OpaqueString;
{
    use base qw(Unicode::Precis);

    sub new {
        bless shift->SUPER::new(
            AdditionalMappingRule => 'Space=Map',
            NormalizationRule     => 'NFC',
            StringClass           => 'FreeFormClass',
        );
    }
}

1;
__END__

=encoding utf-8

=head1 NAME

Unicode::Precis::SASLprep - PRECIS "SASLprep" Profiles

=head1 SYNOPSIS

  use Unicode::Precis::SASLprep;
  
  $profile = Unicode::Precis::UsernameCaseMapped->new;
  $profile = Unicode::Precis::UsernameCasePreserved->new;
  $profile = Unicode::Precis::OpaqueString->new;
  
  $string = $profile->enforce($input);
  $equals = $profile->compare($inputA, $inputB);

=head1 DESCRIPTION

L<Unicode::Precis::SASLprep> provides three PRECIS profiles:
C<UsernameCaseMapped>, C<UsernameCasePreserved> and C<OpaqueString>.

=head1 SEE ALSO

L<Unicode::Precis>.

draft-ietf-precis-saslprepbis,
I<Preparation, Enforcement, and Comparison of Internationalized Strings
Representing Usernames and Passwords>.
L<https://tools.ietf.org/html/draft-ietf-precis-saslprepbis>.

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
