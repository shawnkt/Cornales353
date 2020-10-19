#!/bin/bash
{
    echo '#PBS -S /bin/bash'
    echo '#PBS -N retriveseqs_hybpiper'
    echo '#PBS -q batch'
    echo '#PBS -l nodes=1:ppn=1'
    echo '#PBS -l walltime=50:00:00'
    echo '#PBS -l mem=20gb'

    echo 'cd $PBS_O_WORKDIR'

    echo 'module load HybPiper/1.3.1-foss-2016b-Python-2.7.14'
    echo 'module load bioawk/1.0-foss-2016b'

    echo 'retrieve_sequences.py' $1'/353_targets.fa' $1 'supercontig'
    echo 'for f in *.fasta; do bioawk -c fastx' "'"'{print ">"substr($name,0,3); print $seq}'"'"' $f > ${f::-5}gene; done'
    echo 'rm *.fasta'
} >> retseq.sh
qsub retseq.sh