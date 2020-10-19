#PBS -S /bin/bash
#PBS -N j_ASTRAL250
#PBS -q batch
#PBS -l nodes=1:ppn=1
#PBS -l walltime=30:00:00
#PBS -l mem=20gb

cd $PBS_O_WORKDIR

ml ASTRAL/5.6.1-Java-1.8.0_144

time java -jar $EBROOTASTRAL/astral.5.6.1.jar -q bot2020_250boot.main.tre -i biparts.tre -t 16 -o bot2020_250freq.txt
