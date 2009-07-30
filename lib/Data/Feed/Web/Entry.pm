# $Id: /mirror/coderepos/lang/perl/Data-Feed/trunk/lib/Data/Feed/Web/Entry.pm 102544 2009-03-19T08:58:09.853141Z daisuke  $

package Data::Feed::Web::Entry;
use Any::Moose '::Role';
use Data::Feed::Web::Enclosure;

with 'Data::Feed::Item';

has 'entry' => (
    is => 'rw',
    isa => 'HashRef',
    required => 1,
);

requires 'title';
requires 'link';
requires 'content';
requires 'summary';
requires 'category';
requires 'author';
requires 'id';
requires 'issued';
requires 'modified';
requires 'enclosures';

no Any::Moose '::Role';

1;

__END__

=head1 NAME

Data::Feed::Web::Entry - Role For Web-Related Feed Entry

=cut
