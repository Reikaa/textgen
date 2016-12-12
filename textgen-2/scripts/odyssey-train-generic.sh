#!/bin/bash
#SBATCH -p gpu
#SBATCH -n 1
#SBATCH --gres=gpu:1
#SBATCH -N 1                    # Ensure that all cores are on one machine
#SBATCH -t 5-00:00              # Runtime in D-HH:MM
#SBATCH -p serial_requeue       # Partition to submit to
#SBATCH --mem=20000               # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH --constraint=cuda-7.5
#SBATCH -o train.out      # File to which STDOUT will be written
#SBATCH -e train.err      # File to which STDERR will be written
 
hostname
module load python
module load cuda/7.5-fasrc01
module load cudnn/7.0-fasrc01

filename="4-mod"
weightfile="sherlock-4-1l-512n-"
layers="1"
nodes="512"
epochs="1000"

source activate mypython
KERAS_BACKEND=theano THEANO_FLAGS=mode=FAST_RUN,device=gpu,floatX=float32,lib.cnmem=1 python src/train-generic.py -t $filename -w $weightfile -l $layers -n $nodes -e $epochs