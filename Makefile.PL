use inc::Module::Install;

name     'Test-Mock-Test';
all_from 'lib/Test/Mock/Test.pm';
author   'Steffen Schwigon <ss5@renormalist.net>';
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

