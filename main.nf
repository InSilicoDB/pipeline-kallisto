#!/usr/bin/env nextflow
echo true

cheers = Channel.from 'Bojour', 'Ciao', 'Hello', 'Hola', 'Γεια σου'

process sayHello {
  input: 
  val x from cheers
  
  """
  echo '$x world!'
  """
}
