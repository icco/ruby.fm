module DatabaseHelpers
  def truncate(table, cascade=true)
    sql = cascade ? "TRUNCATE #{table} CASCADE" : "TRUNCATE #{table}"
    ActiveRecord::Base.connection.execute(sql)
  end
end
