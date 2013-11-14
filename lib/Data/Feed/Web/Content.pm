package Data::Feed::Web::Content;
use Moo;

has 'type' => (
    is => 'rw',
);

has 'body' => (
    is => 'rw',
);


1;

__END__

=head1 NAME

Data::Feed::Web::Content - Role For Web-Related Feed Entry Content

=cut
