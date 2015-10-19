#!/usr/bin/env nextflow

//fastaFiles = Channel.fromPath('/Users/jamescauwelier/Code/InSilicoDB/kallisto-pipeline/data/Arabidopsis_thaliana.TAIR10.26.cdna.all.fa.gz')
//indexFile = '/Users/jamescauwelier/Code/InSilicoDB/kallisto-pipeline/data/Arabidopsis_thaliana.TAIR10.26.cdna.all.idx'

//process index {
//
//	container 'kallisto'
//
//	input:
//		file fastaFile from fastaFiles
//
//	"""
//	kallisto index -i ${indexFile} ${fastaFile}
//	"""
//}

echo true

cheers = Channel.from 'Bojour', 'Ciao', 'Hello', 'Hola', 'Γεια σου'

process sayHello {
  input: 
  val x from cheers
  
  """
  echo '$x world!'
  """
}
