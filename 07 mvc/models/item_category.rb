require_relative 'model'

class ItemCategory < Model
    attr_accessor :item, :category

    def initialize(item, category)
        @item = item
        @category = category
    end

    def valid?
        return false if @item.nil?
        return false if @category.nil?

        @item.valid? and @category.valid?
    end

    def update(item, category)
        @item = item
        @category = category
        return unless valid?

        ItemCategory.client.query("update item_categories set category_id='#{@category.id}' where item_id='#{@item.id}'")
        self
    end

    def delete
        Model.client.query("delete from item_categories where item_id='#{@item.id}' and category_id='#{@category.id}'")
    end

    def self.create(item, category)
        item_category = ItemCategory.new(item, category)
        return unless item_category.valid?

        Model.client.query("insert into item_categories (item_id, category_id) values ('#{item_category.item.id}', '#{item_category.category.id}')")
        item_category
    end

    def self.find_by_item(item)
        raw_data = client.query("select * from item_categories where item_id='#{item.id}'")
        data = raw_data.first
        return if data.nil?

        category = Category.find_by_id(data['category_id'])
        ItemCategory.new(item, category)
    end
end