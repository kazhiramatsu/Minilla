package Minilla::CLI::Install;
use strict;
use warnings;
use utf8;
use Path::Tiny;
use Minilla::WorkDir;

sub run {
    my ($self, @args) = @_;

    my $test = 1;
    $self->parse_options(
        \@args,
        'test!' => \$test,
    );

    my $project = Minilla::Project->new(
        c => $self,
    );
    my $work_dir = $project->work_dir();
    if ($test) {
        $work_dir->dist_test();
    }
    my $tar = $work_dir->dist();

    $self->cmd('cpanm', ($self->verbose ? '--verbose' : ()), $tar);
    path($tar)->remove unless $self->debug;
}

1;
__END__

=head1 NAME

Minilla::CLI::Install - Install the dist to system

=head1 SYNOPSIS

    % minil install

        --no-test Do not run test

=head1 DESCRIPTION

This subcommand install the dist for your system.

