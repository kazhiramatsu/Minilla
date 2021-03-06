package Minilla::Release::Tag;
use strict;
use warnings;
use utf8;

sub run {
    my ($class, $c, $opts, $project) = @_;

    my $ver = $project->version;
    if ( $c->dry_run ) {
        $c->infof("DRY-RUN.  Would have tagged version $ver.\n");
        return;
    }

    $c->cmd('git', 'tag', $ver);
    $c->cmd('git', "push", 'origin', tag => $ver);
}

1;

