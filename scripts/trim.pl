#!/usr/bin/perl
use strict;
#Karolina Heyduk - heyduk@uga.edu - 2014

#run in directory where reads are located

my $trimdir = $ARGV[0]; #directory for trimmed files
my $list = $ARGV[1]; #read to ID index file, see manual for example
my %read1;
my %read2;
my @libIDs;

#read library index file, store R1 and R2 in hashes
open IN, "<$list";
while (<IN>) {
	chomp;
	my ($libID, $readID) = split /\t/;
	 if ($readID =~ 'R1') { 
                $read1{$libID} = $readID;
                print "$libID\t$readID\n";
                if ($libID ~~ @libIDs) {
                        next;
                        }
                else {
                        push(@libIDs, $libID);
                        }
                }
        elsif ($readID =~ 'R2') {
                $read2{$libID} = $readID;
                print "$libID\t$readID\n";
                }
	}
close IN;

for my $libID (@libIDs) {   
    open OUT, ">$libID.trim.sh";
	
	#change path to trimmomatic for your usage. Alter phred score (64 or 33) as needed.
	print OUT "
#PBS -S /bin/bash
#PBS -N $libID\_trim
#PBS -q batch
#PBS -l nodes=1:ppn=4
#PBS -l walltime=20:00:00
#PBS -l mem=40gb
cd \$PBS_O_WORKDIR
module load Trimmomatic/0.36-Java-1.8.0_144
time java -jar /usr/local/apps/eb/Trimmomatic/0.36-Java-1.8.0_144/trimmomatic-0.36.jar PE -phred33 -threads 4 $read1{$libID} $read2{$libID} $trimdir/$libID\_R1_P.fastq.gz $trimdir/$libID\_R1_U.fastq.gz $trimdir/$libID\_R2_P.fastq.gz $trimdir/$libID\_R2_U.fastq.gz ILLUMINACLIP:/usr/local/apps/eb/Trimmomatic/0.36-Java-1.8.0_144/adapters/TruSeq2-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36\n";
	system "qsub $libID.trim.sh"
        }
	#change the submission line below to meet your system's needs. If threading is not available, remove the -th flag above.
