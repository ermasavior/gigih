require_relative 'model'
require_relative 'item'

class Category < Model
    attr_accessor :id, :name, :items

    def initialize(id, name, items=[])
        @id = id
        @name = name
        @items = items
    end

    def valid?
        return false if @id.nil?
        return false if @name.nil?
        true
    end

    def self.find_by_id(id)
        raw_data = client.query("select * from categories where id='#{id}'")
        data = raw_data.first
        Category.new(data["id"], data["name"]) unless data.nil?
    end

    def self.find_by_id_with_items(id)
        raw_data = client.query("select * from categories where id='#{id}'")
        data = raw_data.first
        return if data.nil?

        category = Category.new(data["id"], data["name"])
        category.items = Item.find_by_category(category)
        category
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
