require_relative '../db/db_connector'

class Model
    def self.client
        @client ||= DBConnector.client
    end
end
