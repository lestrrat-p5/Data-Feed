use strict;
use Test::More (tests => 26);

BEGIN {
    use_ok("Data::Feed");
}

{
    my $rss = Data::Feed->parse( 't/data/rss10.xml' );

    isa_ok($rss, "Data::Feed::RSS");

    is( $rss->title, 'First Weblog' );

    my @entries = $rss->entries;
    is( @entries, 2 );

    for my $entry (@entries) {
        ok( $entry->title );
    }
}

SKIP: {
    my $class;
    { no warnings 'once';
        $class = $Data::Feed::Parser::RSS::PARSER_CLASS;
    }

    if ( $class eq 'XML::RSS' ) {
        skip( "XML::RSS can't handle enclosures", 19 );
    }

    my $rss = Data::Feed->parse( 't/data/rss-with-media.xml' );

    ok( $rss, "Fetch successful" );
    isa_ok($rss, "Data::Feed::RSS");

    is( $rss->title, '4U' );

    my @entries = $rss->entries;
    is( @entries, 15 );
    ok($entries[0]->links, "got links from the entry");

    for my $entry (@entries) {
        ok( $entry->enclosures, "enclosures for entry are ok" );
    }
}
