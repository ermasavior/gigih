require_relative 'model'

class ItemCategory < Model
    attr_accessor :item, :category

    def initialize(item, category)
        @item = item
        @category = category
    end

    def update(item, category)
        @item = item
        @category = category

        Model.client.query("update item_categories set category_id='#{@category.id}' where item_id='#{@item.id}'")
        self
    end

    def delete
        Model.client.query("delete from item_categories where item_id='#{@item.id}' and category_id='#{@category.id}'")
    end

    def self.create(item, category)
        @item, @category = item, category
        Model.client.query("insert into item_categories (item_id, category_id) values ('#{@item.id}', '#{@category.id}')")
    end

    def self.find_by_item(item)
        raw_data = client.query("select * from item_categories where item_id='#{item.id}'")
        data = raw_data.first
        return if data.nil?

        category = Category.find_by_id(data['category_id'])
        ItemCategory.new(item, category)
    end
end