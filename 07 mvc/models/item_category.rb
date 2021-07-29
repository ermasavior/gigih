require_relative 'model'

class ItemCategory < Model
    attr_reader :item_id, :category_id

    def initialize(item_id, category_id)
        @item_id = item_id
        @category_id = category_id
    end

    def save
        Model.client.query("insert into item_categories (item_id, category_id) values ('#{@item_id}', '#{@category_id}')")
    end
end