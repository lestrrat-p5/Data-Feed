use strict;
use inc::Module::Install;

name('Data-Feed');

all_from('lib/Data/Feed.pm');

requires 'DateTime::Format::Mail';
requires 'DateTime::Format::W3CDTF';
requires 'List::Util';
requires 'URI::Fetch';
requires 'XML::Atom';
requires 'XML::RSS::LibXML';
requires_any_moose;

test_requires('Test::More');
test_requires('Test::UseAllModules');

tests('t/*.t t/*/*.t');

auto_include_deps;
WriteAll;