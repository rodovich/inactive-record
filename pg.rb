begin
  require 'pg'
rescue => LoadError
  puts 'Could not load the pg gem. Run `gem install pg` and try again.'
end

connection = PG.connect({
  host: 'localhost',
  port: '5433',
  user: 'development',
  password: 'development',
  dbname: 'easel_development',
})

result = connection.exec('SELECT id, name FROM projects').to_a

puts result
