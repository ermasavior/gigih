require 'mysql2'
require_relative '../env'

class DBConnector
    attr_reader :client

    def self.client
        @client ||= Mysql2::Client.new(
            :host => ENV["HOST"],
            :username => ENV["DB_USERNAME"],
            :password => ENV["DB_PASSWORD"],
            :database => ENV["DB_DATABASE"]
        )
    end
end
