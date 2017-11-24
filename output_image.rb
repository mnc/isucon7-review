# /home/isucon/local/ruby/bin/bundle exec pry exec pry
# require './app.rb'
class ImageOutput
  PUBLIC_PATH = '/home/isucon/isubata/webapp/public/icons'

  def db
    @db_client ||= Mysql2::Client.new(
      host: ENV.fetch('ISUBATA_DB_HOST') { 'localhost' },
      port: ENV.fetch('ISUBATA_DB_PORT') { '3306' },
      username: ENV.fetch('ISUBATA_DB_USER') { 'isucon' },
      password: ENV.fetch('ISUBATA_DB_PASSWORD') { 'isucon' },
      database: 'isubata',
      encoding: 'utf8mb4'
    )
    @db_client.query('SET SESSION sql_mode=\'TRADITIONAL,NO_AUTO_VALUE_ON_ZERO,ONLY_FULL_GROUP_BY\'')
    @db_client
  end

  def run
    statement = db.prepare('SELECT * FROM image')
    rows = statement.execute.to_a
    rows.each_with_index do |row, i|
      puts "current: #{i}"
      File.open("#{PUBLIC_PATH}/#{row['name']}", 'w') {|f| f.write(row["data"]) }
    end
    statement.close
  end
end

ImageOutput.new.run
