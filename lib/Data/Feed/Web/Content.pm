# $Id: /mirror/coderepos/lang/perl/Data-Feed/trunk/lib/Data/Feed/Web/Content.pm 102544 2009-03-19T08:58:09.853141Z daisuke  $

package Data::Feed::Web::Content;
use Any::Moose;

has 'type' => (
    is => 'rw',
    isa => 'Str',
);

has 'body' => (
    is => 'rw',
    isa => 'Str',
);

__PACKAGE__->meta->make_immutable;

no Any::Moose;

1;

__END__

=head1 NAME

Data::Feed::Web::Content - Role For Web-Related Feed Entry Content

=cut
