require_relative 'model'

class Item < Model
    attr_reader :id, :name, :price, :category

    def initialize(id, name, price, category)
        @id = id
        @name = name
        @price = price
        @category = category
    end

    def self.find_all_items_with_category
        puts client
        raw_data = client.query("select items.id, items.name as 'item_name', items.price, categories.name as 'category_name'
                                 from items
                                 left join item_categories on items.id = item_categories.item_id
                                 left join categories on categories.id = item_categories.category_id")
        items = Array.new
        raw_data.each do |data|
            item = Item.new(data["id"], data["item_name"], data["price"], data["category_name"])
            items.push(item)
        end

        items
    end
end
