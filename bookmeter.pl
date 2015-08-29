#!/usr/bin/env perl
use strict;
use warnings;
use Web::Scraper;
use WWW::Mechanize;
use Data::Dumper;
use Config::Pit;
use utf8;
use Encode;
#サービスID, アイテムID, 13桁ISBN, カテゴリ, 評価, 読書状況, レビュー, タグ, 非公開メモ, 登録日時, 読了日

my $config = pit_get("bookmeter.com");
my $baseurl = 'http://bookmeter.com/login';
my $mech = WWW::Mechanize->new(
    agent => 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/28.0.1500.63 Safari/537.36'
);
$mech->get($baseurl);
$mech->submit_form(
    fields      => {
        mail     => $config->{mail},
        password => $config->{password},
    },
    form_number => 2,
);

$mech->get('http://bookmeter.com/home?main=book&display=list');

my $data = $mech->content;
print encode('utf8',$data);
