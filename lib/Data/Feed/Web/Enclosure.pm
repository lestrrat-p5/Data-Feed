
package Data::Feed::Web::Enclosure;

use Moo;

has 'url' => (
    is => 'rw',
    required => 1,
);

has 'length' => (
    is => 'rw',
);

has 'type' => (
    is => 'rw',
);

1;

__END__

=head1 NAME

Data::Feed::Web::Enclosure - Module For Web-Related Feed Enclosure

=cut
