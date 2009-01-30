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
        'DBIx::Class' => 0.08010,
        'Exception::Class' => 1.23,
        'SQL::Translator' => 0.08,
        'Sub::Exporter' => 0.981,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Games-Framework-RCP-*' },
    test                => { TESTS => "@test_files" },
);
