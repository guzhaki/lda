#!/bin/bash

DATASETS="pubmed" #"nytimes"
METHODS="aliasLDA" # "FTreeLDA sparseLDA lightLDA"
NUM_ITER="1000"
NUM_TOPICS="1024"
NST="28"
NTT="4"

for DATASET in $DATASETS
do
for METHOD in $METHODS
do
	#Create the directory structure
	time_stamp=`date "+%b_%d_%Y_%H.%M.%S"`
	DIR_NAME='res'/$DATASET/$METHOD/$time_stamp/
	mkdir -p $DIR_NAME

	#Display details about current experiment
	echo 'Running LDA inference using' $METHOD
	echo 'For dataset' $DATASET
	echo 'For number of iterations' $NUM_ITER
	echo 'For number of topics' $NUM_TOPICS
	echo 'with results being stored in' $DIR_NAME
	echo 'Using '$NST' sampling thread on c4.8x'
	echo 'Using '$NTT' updating thread on c4.8x'

	#save details about experiments in an about file
	`echo 'Running LDA inference using' $METHOD > $DIR_NAME/log.txt`
	`echo 'For dataset' $dataset >> $DIR_NAME/log.txt`
	`echo 'For number of iterations' $NUM_ITER >> $DIR_NAME/log.txt`
	`echo 'For number of topics' $NUM_TOPICS >> $DIR_NAME/log.txt`
	`echo 'Using '$NST' sampling thread on c4.8x' >> $DIR_NAME/log.txt`
	`echo 'Using '$NTT' updating thread on c4.8x' >> $DIR_NAME/log.txt`


	#run
	./"$METHOD" -net -nst $NST -ntt $NTT -ntopics $NUM_TOPICS -niters $NUM_ITER -odir $DIR_NAME -twords 15 -dfile ../data/"$DATASET".train -tfile "$DATASET".test | tee -a $DIR_NAME/log.txt
done
done

echo 'done'
