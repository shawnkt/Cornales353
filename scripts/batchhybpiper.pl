#!/usr/bin/perl
use strict;
use Cwd;
use Data::Dumper;
#Shawn Thomas - shawnt@uga.edu - 2018
#modified from script by Karolina Heyduk
#perl batchhybpiper.pl </hyb/dir/> </cleaned/reads/> 8 libIDs.txt
my $dir = $ARGV[0]; #FULL PATH to hybpiper folder
my $reads = $ARGV[1]; #FULL PATH to cleaned reads directory
my $CPU = $ARGV[2];
my $list = $ARGV[3]; #list of libIDs, should be the prefix of trimmomatic outputs
my @files = glob("*fastq"); #push files with correct ending into an array
my %control;
my $wd = getcwd;

#read library index file, store in hash
my %paired1;
my %paired2;
my %unpaired1;
my %unpaired2;
my @libIDs;
open IN, "<$list";
while (<IN>) {
	chomp;
	push (@libIDs, $_);
	}
close IN;
print "@libIDs\n";

#make trinity folders and submission scripts
for my $libID (@libIDs) {       
#        system "mkdir $dir/$libID"; 
#		chdir("$dir/$libID");
		open OUT, ">$libID.hybpiper.sh"; #make a shell file for hybpiper submission
        print OUT "
#PBS -S /bin/bash
#PBS -N $libID\_hybpiper
#PBS -q batch
#PBS -l nodes=1:ppn=8
#PBS -l walltime=200:00:00
#PBS -l mem=100gb

cd \$PBS_O_WORKDIR

module load HybPiper/1.3.1-foss-2016b-Python-2.7.14

reads_first.py -b $dir/353_targets.fa -r $reads/$libID\_R*_P.fastq --prefix $libID --bwa --cpu $CPU \n
interonerate.py --prefix $libID $dir";
        system "qsub ./$libID.hybpiper.sh";
		chdir("$wd");
		close OUT;
        }
