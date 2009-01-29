#!perl

use Test::More;

eval "use Test::UseAllModules";
if ($@)
{
    plan skip_all => 'Install Test::UseAllModules to see all of the modules load.';
}
all_uses_ok();