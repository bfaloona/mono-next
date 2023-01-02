 # This file was originally written for Padrino 0.13 by
 # Brandon Faloona, then migrated to Sinatra 3.0.5 by
 # GPT-3's text-davinci-003 engine, with prompts from Steven Shults. 
 # December 2022.
 #
require 'sinatra'
require 'pry'

# Disable verbose warnings
$VERBOSE = nil

# Set the IRB to Pry
IRB = Pry

# Re-enable verbose warnings
$VERBOSE = false