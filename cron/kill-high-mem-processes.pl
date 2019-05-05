#!/run/current-system/sw/bin/perl

use strict;
use warnings;
use Proc::ProcessTable;

my $table = Proc::ProcessTable->new;

for my $process (@{$table->table}) {
    # skip root processes
    next if $process->uid == 0 or $process->gid == 0;
		
    # skip any using less than 10 GiB
    next if $process->rss < 10_073_741_824;

    # document the slaughter
    (my $cmd = $process->cmndline) =~ s/\s+\z//;
    print "Killing process: pid=", $process->pid, " uid=", $process->uid, " rss=", $process->rss, " fname=", $process->fname, " cmndline=", $cmd, "\n";

    # try first to terminate process politely
    kill 15, $process->pid;

    # wait a little, then kill ruthlessly if it's still around
    sleep 5;
    kill 9, $process->pid;
}
