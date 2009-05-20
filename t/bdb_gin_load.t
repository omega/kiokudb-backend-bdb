#!/usr/bin/perl -w

use strict;
use Test::More tests => 2;
use Test::TempDir;
use KiokuDB::Cmd::Command::Load;
use KiokuDB;

use Search::GIN::Query::Manual;


my $b = KiokuDB->connect('bdb-gin:dir=' . temp_root, create => 1);

open(my $fh, "<", 't/gin.yml') or die "cannot read t/gin.yml: $!";

my $loader = KiokuDB::Cmd::Command::Load->new(
        backend => $b->backend,
        input_handle => $fh,
);

$loader->run;


{
    my $scope = $b->new_scope;
    
    my $stream = $b->search(Search::GIN::Query::Manual->new(
        values => { name => 'ekeberg', TYPE => 'Course'}
    ));
    my @all = $stream->all;

    ok($all[0]);
    is($all[0]->name, 'ekeberg');
}
