#!/usr/bin/env perl
use strict;
use ojo;
use Net::MQTT::Simple::SSL;
use Encode qw(encode decode);

for (qw(MQTT_SERVER MQTT_USER MQTT_PASSWORD)) {
  die "Missing configuration variable $_" unless $ENV{$_};
}

my $handle_ding = sub {
  my ($topic, $message) = @_;
  p('https://hackeriet.no/hackerietbot/oslohackerspace' =>
    {Accept => '*/*'} => json => { msg => '[DING DONG] '. decode("UTF-8", $message) } );
  warn "[DING DONG] $message\n";
};

my $mqtt = Net::MQTT::Simple::SSL->new($ENV{MQTT_SERVER});
$mqtt->login( $ENV{MQTT_USER}, $ENV{MQTT_PASSWORD} );
$mqtt->run( "hackeriet/ding" => $handle_ding );
