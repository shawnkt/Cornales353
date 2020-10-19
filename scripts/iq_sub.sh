#!/bin/bash

for f in *.aln
do 
    {
        echo '#PBS -S /bin/bash'
        echo '#PBS -q batch'
        echo '#PBS -N' ${f::4}'_iq'
        echo '#PBS -l nodes=1:ppn=2'
        echo '#PBS -l walltime=10:00:00'
        echo '#PBS -l mem=10gb'

        echo 'cd $PBS_O_WORKDIR'

        echo 'module load IQ-TREE/1.6.5-omp'
        echo 'iqtree -s' $f '-m MFP -bb 1000 -wbt -nt 2 -mem 10G -pre' ${f::4}
    } >> ${f::4}_iq.sh
    qsub ${f::4}_iq.sh
    echo ${f::4}_iq 'Submitted!'
done

