use strict;
use warnings;
use ExtUtils::MakeMaker;

my @test_files = qw(t/*.t t/*/*.t t/*/*/*.t);


WriteMakefile(
    NAME                => 'Games::Framework::RCP',
    AUTHOR              => 'Jason Felds <wolfman.ncsu2000@gmail.com>',
    VERSION_FROM        => 'lib/Games/Framework/RCP.pm',
    ABSTRACT_FROM       => 'lib/Games/Framework/RCP.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM =>
    {
        'Class::Singleton' => 1.4,
        'DBD::Pg' => 2.11,
        'Readonly' => 1.03,
        'Exception::Class' => 1.23,
        'Scalar::Util::Numeric' => 0.02,
        #'Sub::Exporter' => 0.981,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Games-Framework-RCP-*' },
    test                => { TESTS => "@test_files" },
);
