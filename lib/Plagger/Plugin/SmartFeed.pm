package Plagger::Plugin::SmartFeed;
use strict;
use base qw( Plagger::Plugin );

use Plagger::Tag;

sub rule_hook { 'smartfeed.entry' }

sub register {
    my($self, $context) = @_;
    $context->register_hook(
        $self,
        'smartfeed.init'  => \&feed_init,
        'smartfeed.entry' => \&feed_entry,
        'smartfeed.finalize' => \&feed_finalize,
    );
}

sub feed_init {
    my($self, $context, $args) = @_;

    my $feed = Plagger::Feed->new;
    $feed->type('smartfeed');
    $feed->id( $self->conf->{id} || ('smartfeed:' . $self->rule->id) );
    $feed->title( $self->conf->{title} || "Entries " . $self->rule->as_title );

    $self->{feed} = $feed;
}

sub feed_entry {
    my($self, $context, $args) = @_;
    $self->{feed}->add_entry($args->{entry}->clone);
}

sub feed_finalize {
    my($self, $context, $args) = @_;
    $context->update->add($self->{feed}) if $self->{feed}->count;
}

1;
