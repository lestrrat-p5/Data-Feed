package Data::Feed::Atom::Entry;
use Any::Moose;
use Data::Feed::Web::Content;
use List::Util qw( first );
use XML::Atom::Util qw( iso2dt );
use XML::Atom::Entry;

with 'Data::Feed::Web::Entry';

has '+entry' => (
    isa => 'XML::Atom::Entry'
);

__PACKAGE__->meta->make_immutable;

no Any::Moose;

BEGIN {
    my %methods = map { ( $_ => $_ ) } qw(title updated);
    while ( my ( $name, $proxy ) = each %methods ) {
        __PACKAGE__->meta->add_method(
            $name => sub { shift->entry->$proxy(@_) } );
    }
}

sub _build_entry { return XML::Atom::Entry->new() }

sub link {
    my $entry = shift;
    if (@_) {
        $entry->entry->add_link({ rel => 'alternate', href => $_[0],
                                    type => 'text/html', });
    } else {
        my $l = first { !defined $_->rel || $_->rel eq 'alternate' } $entry->entry->link;
        $l ? $l->href : undef;
    }
}

sub links {
    my $entry = shift;
    return $entry->entry->link;
}

sub summary {
    my $entry = shift;
    if (@_) {
        $entry->entry->summary(
            (Scalar::Util::blessed($_[0]) || '') eq 'Data:::Feed::Web::Content' ?
                $_[0]->body : $_[0]
        );
    } else {
        Data::Feed::Web::Content->new( type => 'html',
                                   body => $entry->entry->summary || '' );
    }
}

sub content {
    my $entry = shift;
    if (@_) {
        my %param;
        if (Scalar::Util::blessed $_[0] && $_[0]->isa('Data::Feed::Web::Content')) {
            %param = (Body => $_[0]->body);
        } else {
            %param = (Body => $_[0]);
        }
        $entry->entry->content(XML::Atom::Content->new(%param, Version => 1.0));
    } else {
        my $c = $entry->entry->content;

        # map Atom types to MIME types
        my $type = $c ? $c->type : 'text';
        if ($type) {
            $type = 'text/html'  if $type eq 'xhtml' || $type eq 'html';
            $type = 'text/plain' if $type eq 'text';
        }

        Data::Feed::Web::Content->new( type => $type,
                                   body => $c ? $c->body : '' );
    }
}

sub category {
    my $entry = shift;
    my $ns = XML::Atom::Namespace->new(dc => 'http://purl.org/dc/elements/1.1/');
    if (@_) {
        $entry->entry->add_category({ term => $_[0] });
    } else {
        my $category = $entry->entry->category;
        $category ? ($category->label || $category->term) : $entry->entry->get($ns, 'subject');
    }
}

sub author {
    my $entry = shift;
    if (@_ && $_[0]) {
        my $person = XML::Atom::Person->new(Namespace => $entry->entry->ns, Version => 1.0);
        $person->name($_[0]);
        $entry->entry->author($person);
    } else {
        $entry->entry->author ? $entry->entry->author->name : undef;
    }
}

sub id { shift->entry->id(@_) }

sub issued {
    my $entry = shift;
    if (@_) {
        $entry->entry->issued(DateTime::Format::W3CDTF->format_datetime($_[0])) if $_[0];
    } else {
        $entry->entry->issued ? iso2dt($entry->entry->issued) : undef;
    }
}

sub modified {
    my $entry = shift;
    if (@_) {
        $entry->entry->modified(DateTime::Format::W3CDTF->format_datetime($_[0])) if $_[0];
    } else {
        $entry->entry->modified ? iso2dt($entry->entry->modified) : undef;
    }
}

sub enclosures {
    my $self = shift;

    die if @_;

    my @enclosures;
    for my $link ( grep { defined $_->rel && $_->rel eq 'enclosure' } $self->entry->link ) {
        my $enclosure = Data::Feed::Web::Enclosure->new(
            url => $link->href,
        );
        $enclosure->length($link->length) if $link->length;
        $enclosure->type($link->type);
        push @enclosures, $enclosure;
    }

    @enclosures;
}

1;

__END__

=head1 NAME

Data::Feed::Atom::Entry - An Atom Entry

=head1 METHODS

=head2 author

=head2 category

=head2 content

=head2 enclosures

=head2 id

=head2 issued

=head2 link

=head2 modified

=head2 summary

=head2 title

=cut

