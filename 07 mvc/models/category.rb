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
        return false if @name.nil?
        true
    end

    def self.create(name)
        category = Category.new(nil, name)
        return unless category.valid?

        client.query("insert into categories(name) values ('#{category.name}')")
        category.id = self.client.last_id
        category
    end

    def update(name)
        @name = name
        return unless valid?

        Model.client.query("update categories set name='#{@name}' where id='#{@id}'")
        self
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
