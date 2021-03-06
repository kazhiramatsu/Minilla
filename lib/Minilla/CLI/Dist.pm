package Minilla::CLI::Dist;
use strict;
use warnings;
use utf8;
use Minilla::Project;
use Path::Tiny;

sub run {
    my ($self, @args) = @_;

    my $test = 1;
    $self->parse_options(
        \@args,
        'test!' => \$test,
    );

    my $project = Minilla::Project->new(
        c => $self
    );
    my $work_dir = $project->work_dir;
    if ($test) {
        $work_dir->dist_test();
    }
    my $tar = $work_dir->dist();
    my $dst = path($project->dir, path($tar)->basename);
    path($tar)->copy($dst);
}

1;
__END__

=head1 NAME

Minilla::CLI::Dist - Make tar ball distribution

=head1 SYNOPSIS

    % minil dist

=head1 DESCRIPTION

This subcommand makes distribution tar ball.

