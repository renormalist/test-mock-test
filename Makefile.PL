use inc::Module::Install;

name     'Test-Mock-AllTestsOk';
all_from 'lib/Test/Mock/AllTestsOk.pm';
author   'Steffen Schwigon <ss5@renormalist.net>';
license  'perl';

build_requires 'Test::More';

auto_install;

WriteAll;

