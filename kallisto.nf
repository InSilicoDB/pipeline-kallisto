#!/usr/bin/env nextflow

// default parameter values

params.fastaFile = 's3://pipelines-microservice-data/kallisto/transcripts.fasta.gz'
params.fastqFile1 = 's3://pipelines-microservice-data/kallisto/reads_1.fastq.gz'
params.fastqFile2  = 's3://pipelines-microservice-data/kallisto/reads_2.fastq.gz'
params.out = "$PWD/out/"

// input files

fasta = file(params.fastaFile)
fastq1 = file(params.fastqFile1)
fastq2 = file(params.fastqFile2)

// output 

result = file(params.out)

process indexation {

	container 'insilicodb/kallisto'

	input:
	file fasta

	output:
	file 'index.idx' into INDEX

	"""
	kallisto index -i index.idx $fasta
	"""

}


process quantification {
	
	container 'insilicodb/kallisto'

	input:
	file idxFile from INDEX
	file fastq1
	file fastq2

	output:
	file "./out/abundance.h5" into QUANT

	"""
	kallisto quant --index=$idxFile --output=./out $fastq1 $fastq2
	"""

}


process exportRObject {

	container 'insilicodb/kallisto'
	
	input:
	file quantH5 from QUANT

	output:
	file "kallisto_sleuth.RData" into OUTPUT

	script:
	"""
	#! /usr/bin/env Rscript

	library("sleuth")
	k <- read_kallisto("${quantH5}")
	save(k, file = "./kallisto_sleuth.RData")
	"""

}

process collectOutput {

	input:
	file filename from OUTPUT

	"""
	mkdir -p ${params.out}
	cp ${filename} ${params.out}${filename}
	"""
}
