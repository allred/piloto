$: << File.join(File.dirname(__FILE__), 'lib')
require 'active_record'

ActiveRecord::Base.establish_connection(
  :adapter => 'postgresql',
  :database => 'piloto_development',
)
