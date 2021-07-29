require_relative 'model'
require_relative 'item_category'

class Item < Model
    attr_reader :id, :name, :price, :category

    def initialize(id, name, price, category=nil)
        @id = id
        @name = name
        @price = price
        @category = category
    end

    def self.create(name, price, category=nil)
        client.query("insert into items (name, price) values ('#{name}', '#{price}')")
        return if category.nil?

        item_id = self.client.last_id
        ItemCategory.new(item_id, category.id).save
    end

    def self.find_by_id(id)
        raw_data = client.query("select items.id as 'item_id', items.name as 'item_name', items.price, categories.id as 'category_id', categories.name as 'category_name'
                                 from items
                                 left join item_categories on items.id = item_categories.item_id
                                 left join categories on categories.id = item_categories.category_id
                                 where items.id = #{id}")
        items = Array.new
        raw_data.each do |data|
            category = Category.new(data["categories.id"], data["category_name"])
            item = Item.new(data["item_id"], data["item_name"], data["price"], category)
            items.push(item)
        end
        items.first
    end

    def self.find_all_items_with_category
        raw_data = client.query("select items.id as 'item_id', items.name as 'item_name', items.price, categories.id as 'category_id', categories.name as 'category_name'
                                 from items
                                 left join item_categories on items.id = item_categories.item_id
                                 left join categories on categories.id = item_categories.category_id")
        items = Array.new
        raw_data.each do |data|
            category = Category.new(data["categories.id"], data["category_name"])
            item = Item.new(data["item_id"], data["item_name"], data["price"], category)
            puts item.id
            items.push(item)
        end

        items
    end
end
