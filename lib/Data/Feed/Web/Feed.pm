# $Id: /mirror/coderepos/lang/perl/Data-Feed/trunk/lib/Data/Feed/Web/Feed.pm 102544 2009-03-19T08:58:09.853141Z daisuke  $

package Data::Feed::Web::Feed;
use Any::Moose '::Role';

has 'feed' => (
    is => 'rw',
);

requires qw(
    add_entry
    as_xml
    author
    copyright
    description
    entries
    format
    generator
    language
    link
    modified
    title
);

no Any::Moose '::Role';

1;

__END__

=head1 NAME

Data::Feed::Web::Feed - Role For Web-Related Feeds

=cut
