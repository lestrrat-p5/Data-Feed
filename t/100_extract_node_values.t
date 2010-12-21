use strict;
use Test::More;
use Data::Feed;

subtest 'rss with feedburner' => sub {
    my @links = qw(
        http://justatheory.com/computers/programming/perl/serious-dbix-connector-bug-fixed.html
        http://justatheory.com/computers/databases/postgresql/fk-locks-project.html
        http://justatheory.com/computers/programming/cocoa/git-build-number-in-xcode.html
        http://justatheory.com/autobiographical/since-undergrad.html
        http://justatheory.com/computers/databases/postgresql/key-value-pairs.html
        http://justatheory.com/computers/databases/postgresql/pgxn/blog-twitterstream.html
        http://justatheory.com/computers/databases/mysql/introducing_mysql.html
        http://justatheory.com/computers/conferences/oscon2010/tddd-flipr-at-oscon.html
        http://justatheory.com/computers/databases/postgresql/pgxn-development-project.html
        http://justatheory.com/computers/internet/weblogs/atom-sources.html
        http://justatheory.com/computers/programming/perl/handling-multiple-exceptions.html
        http://justatheory.com/family/anna/anna-turns-five.html
        http://justatheory.com/computers/programming/perl/fuck-typing-lwp.html
        http://justatheory.com/computers/databases/postgresql/pgan-bikeshedding.html
        http://justatheory.com/computers/programming/perl/defend-against-mistakes.html
    );

    my $feed = Data::Feed->parse( "t/data/theory.rss" );
    foreach my $entry ( $feed->entries ) {
        my ($origlink) = $entry->extract_node_values( "origLink" => "feedburner" );
        ok $origlink, "was able to extract original link";
        is $origlink, shift @links, "link content matches";
    }
};

subtest 'atom with feedburner' => sub {
    my @links = qw(
        http://www.justatheory.com/computers/programming/perl/serious-dbix-connector-bug-fixed.html
        http://www.justatheory.com/computers/databases/postgresql/fk-locks-project.html
        http://www.justatheory.com/computers/programming/cocoa/git-build-number-in-xcode.html
        http://www.justatheory.com/autobiographical/since-undergrad.html
        http://www.justatheory.com/computers/databases/postgresql/key-value-pairs.html
        http://www.justatheory.com/computers/databases/postgresql/pgxn/blog-twitterstream.html
        http://www.justatheory.com/computers/databases/mysql/introducing_mysql.html
        http://www.justatheory.com/computers/conferences/oscon2010/tddd-flipr-at-oscon.html
        http://www.justatheory.com/computers/databases/postgresql/pgxn-development-project.html
        http://www.justatheory.com/computers/internet/weblogs/atom-sources.html
        http://www.justatheory.com/computers/programming/perl/handling-multiple-exceptions.html
        http://www.justatheory.com/family/anna/anna-turns-five.html
        http://www.justatheory.com/computers/programming/perl/fuck-typing-lwp.html
        http://www.justatheory.com/computers/databases/postgresql/pgan-bikeshedding.html
        http://www.justatheory.com/computers/programming/perl/defend-against-mistakes.html
    );
    my $feed = Data::Feed->parse( "t/data/theory.atom" );
    foreach my $entry ( $feed->entries ) {
        my ($origlink) = $entry->extract_node_values( "origLink" => "feedburner" );
        ok $origlink, "was able to extract original link";
        is $origlink, shift @links, "link content matches";
    }
};

done_testing;
