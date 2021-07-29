require_relative 'model'

class Category < Model
    attr_reader :id, :name

    def initialize(id, name)
        @id = id
        @name = name
    end

    def self.find_by_id(id)
        raw_data = client.query("select * from categories")
        data = raw_data.first
        Category.new(data["id"], data["name"]) unless data.nil?
    end

    def self.find_all_categories
        raw_data = client.query("select * from categories")
        categories = Array.new
        raw_data.each do |data|
            category = Category.new(data["id"], data["name"])
            categories.push(category)
        end

        categories
    end
end
