# Author: Dr. Teresa Vasquez
# Begins the program, checks for the DB and sets the root directory for files
# run in the command line: ruby init.rb

APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'store'

store = Store.new("bangazon_store.sqlite")
store.launch!