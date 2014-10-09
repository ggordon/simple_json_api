require 'rails'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3', database: ':memory:'
)
load File.dirname(__FILE__) + '/setup/schema.rb'

# dump the actual schema
# require 'active_record/schema_dumper'
# filename = File.join('test', 'tmp', 'schema.rb')
# File.open(filename, 'w:utf-8') do |file|
#   ActiveRecord::SchemaDumper.dump(ActiveRecord::Base.connection, file)
# end

require 'setup/models'
require 'setup/serializers'

load File.dirname(__FILE__) + '/setup/data.rb'
