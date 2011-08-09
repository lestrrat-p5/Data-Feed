use strict;
use utf8;
use Test::More;
use URI;
use Data::Feed;

my $cwd = Cwd::abs_path( Cwd::cwd() );
foreach my $enc ( qw( euc utf8 ) ) {
    my $feed = Data::Feed->parse( URI->new( "file://$cwd/t/data/rss20-$enc.xml" ) );

    foreach my $entry ($feed->entries) {
        is $entry->title, "日本語のテスト", "encoding from $enc is correct";
    }
    ok 1;
};

done_testing;