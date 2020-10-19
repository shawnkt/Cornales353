#!/usr/bin/perl
use strict;
use Cwd;
use Data::Dumper;
#Shawn Thomas - shawnt@uga.edu - 2019
#USAGE: perl pasta.pl <pasta/dir/> <listofgenes.txt>


my $dir = $ARGV[0]; #FULL PATH to pasta folder, include final "/"
my $list = $ARGV[1]; #list of genes, should same as folder names
my %control;
my $wd = getcwd;

#read gene index file, store in hash
my @genes;
open IN, "<$list";
while (<IN>) {
	chomp;
	push (@genes, $_);
	}
close IN;
print "@genes\n";

#make pasta submission scripts
for my $gene (@genes) {      
#		chdir("$dir/$gene");
		open OUT, ">$gene.pasta.sh"; #make a shell file for pasta submission
        print OUT "
#PBS -S /bin/bash
#PBS -N $gene.pasta
#PBS -q batch
#PBS -l nodes=1:ppn=1
#PBS -l walltime=100:00:00
#PBS -l mem=65gb  
cd \$PBS_O_WORKDIR
module load PASTA/1.8.2-foss-2016b-Python-2.7.14

run_pasta.py --max-mem-mb=64000 -i $gene.bot2020.sc.fa -j $gene -d DNA > output_\${PBS_JOBID}.log";
        system "qsub ./$gene.pasta.sh";
		chdir("$wd");
 		close OUT;
        }
