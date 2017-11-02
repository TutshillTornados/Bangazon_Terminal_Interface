APP_ROOT = File.dirname(__FILE__)

$:.unshift( File.join(APP_ROOT, 'lib') )
require 'store'

store = Store.new("bangazon_store.sqlite")
store.launch!