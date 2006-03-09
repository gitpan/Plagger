package Plagger::Plugin::Filter::FeedBurnerPermalink;
use strict;
use base qw( Plagger::Plugin );

sub register {
    my($self, $context) = @_;
    $context->register_hook(
        $self,
        'update.entry.fixup' => \&filter,
    );
}

sub filter {
    my($self, $context, $args) = @_;

    my $entry = $args->{entry};
    if ($entry->link =~ m!^http://feeds\.feedburner\.(com|jp)/!) {
        $entry->permalink( $entry->id . "" ); # stringify guid
    }
}

1;

__END__

=head1 NAME

Plagger::Plugin::Filter::FeedBurnerPermalink - Fix FeedBurner's permalink

=head1 SYNOPSIS

  - module: Filter::FeedBurnerPermalink

=head1 DESCRIPTION

Entries in FeedBurner feeds contain links to feedburner's URL
redirector and that breaks some plugins like social bookmarks
integration.

This plugin updates the C<< $entry->permalink >> with I<guid> value in
FeedBurner's feed, so it actually points to the permalink, rather than
redirector.

Note that C<< $entry->link >> will still point to the redirector.

=head1 AUTHOR

Masahiro Nagano

Tatsuhiko Miyagawa

=head1 SEE ALSO

L<Plagger>, L<http://www.feedburner.com/>

=cut