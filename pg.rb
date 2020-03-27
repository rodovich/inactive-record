begin
  require 'pg'
rescue => LoadError
  puts 'Could not load the pg gem. Run `gem install pg` and try again.'
end

require './support/string'
require './inactive_record/base'
require './inactive_record/connection'
require './inactive_record/relation'

class Project < InactiveRecord::Base
end
