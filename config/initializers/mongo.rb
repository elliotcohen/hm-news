if ENV['MONGOHQ_URL'].nil?
  File.open(File.join(Rails.root, 'config/mongoid.yml'), 'r') do |f|
    @settings = YAML.load(f)[Rails.env]
  end

  port = @settings["port"].nil? ? Mongo::Connection::DEFAULT_PORT : @settings["port"]
  connection = Mongo::Connection.new(@settings["host"], port )
  @username = @settings['username']
  @password = @settings['password']
  @db = @settings['database']
else
  connection = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'])
  @db = connection.auths[0]['db_name']
  @username = connection.auths[0]['username']
  @password = connection.auths[0]['password']
end

Mongoid.database = connection.db(@db)
if !@username.blank?
  Mongoid.database.authenticate(@username, @password)
end
