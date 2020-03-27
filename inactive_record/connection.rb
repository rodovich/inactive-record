module InactiveRecord
  def self.connection
    @connection ||= PG.connect({
      host: 'localhost',
      port: '5433',
      user: 'development',
      password: 'development',
      dbname: 'easel_development',
    })
  end

  def self.execute_sql(sql)
    puts sql
    connection.exec(sql).to_a
  end
end
