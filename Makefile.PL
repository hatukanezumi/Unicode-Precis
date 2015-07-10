use 5.008001;

use ExtUtils::MakeMaker;

WriteMakefile(
    NAME             => 'Unicode::Precis',
    VERSION_FROM     => 'lib/Unicode/Precis.pm',
    MIN_PERL_VERSION => 5.008007,
    PREREQ_PM        => {
        'Encode'                       => '0',
	'Unicode::BiDiRule'            => '0.02',
        'Unicode::Normalize'           => '0.28',
        'Unicode::Precis::Preparation' => '0.01',
    },
    ABSTRACT_FROM => 'lib/Unicode/Precis.pm',
    AUTHOR        => 'Hatuka*nezumi - IKEDA Soji <hatuka@nezumi.nu>',
);

