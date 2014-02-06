use ExtUtils::MakeMaker 6.30;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'List::Multicall',
    VERSION_FROM      => 'lib/List/Multicall.pm',
    CONFIGURE_REQUIRES => {
        "ExtUtils::MakeMaker" => "6.30",
    },
    "TEST_REQUIRES" => {
        "Test::More" => "0.88"
    },
    ($] >= 5.005 ?
      (ABSTRACT_FROM  => 'lib/List/Multicall.pm',
       AUTHOR         => 'Matthew Horsfall <wolfsage@gmail.com>') : ()),
    OBJECT            => '$(O_FILES)',
);
