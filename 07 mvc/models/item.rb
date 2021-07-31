require_relative 'model'
require_relative 'item_category'

class Item < Model
    attr_accessor :id, :name, :price, :category

    def initialize(id, name, price, category=nil)
        @id = id
        @name = name
        @price = price
        @category = category
    end

    def valid?
        return false if @name.nil?
        return false if @price.nil?
        true
    end

    def update(name, price, category)
        @name, @price, @category = name, price, category
        return unless valid?

        Model.client.query("update items set name='#{@name}', price='#{@price}' where id='#{@id}'")

        item_category = ItemCategory.find_by_item(self)
        if @category.nil?
            item_category.delete unless item_category.nil?
            return self
        end
        item_category.update(self, @category) unless item_category.nil?

        ItemCategory.create(self, @category) if item_category.nil?
        self
    end

    def delete
        item_category = ItemCategory.find_by_item(self)
        item_category.delete unless item_category.nil?

        Model.client.query("delete from items where id='#{@id}'")
    end

    def self.create(name, price, category=nil)
        item = Item.new(nil, name, price)
        return unless item.valid?

        client.query("insert into items (name, price) values ('#{name}', '#{price}')")
        item.id = self.client.last_id
        item.category = category

        return item if category.nil?

        ItemCategory.create(item, category)
        item
    end

    def self.find_by_id(id)
        raw_data = client.query("select items.id as 'item_id', items.name as 'item_name', items.price, categories.id as 'category_id', categories.name as 'category_name'
                                 from items
                                 left join item_categories on items.id = item_categories.item_id
                                 left join categories on categories.id = item_categories.category_id
                                 where items.id = #{id}")
        items = Array.new
        raw_data.each do |data|
            category = nil
            category = Category.new(data["category_id"], data["category_name"]) unless data["category_id"].nil?
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
            category = nil
            category = Category.new(data["category_id"], data["category_name"]) unless data["category_id"].nil?
            item = Item.new(data["item_id"], data["item_name"], data["price"], category)
            items.push(item)
        end

        items
    end
end
