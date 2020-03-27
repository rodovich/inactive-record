begin
  require 'pg'
rescue => LoadError
  puts 'Could not load the pg gem. Run `gem install pg` and try again.'
end

require_relative 'support/string'
require_relative 'inactive_record/base'
require_relative 'inactive_record/connection'
require_relative 'inactive_record/relation'

class Project < InactiveRecord::Base
  belongs_to :user
end

class User < InactiveRecord::Base
  has_many :projects
end
