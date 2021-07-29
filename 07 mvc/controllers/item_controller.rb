require_relative '../models/item'
require_relative '../models/category'

class ItemController
    def list_items
        items = Item.find_all_items_with_category
        renderer = ERB.new(File.read("./views/index.erb"))
        renderer.result(binding)
    end

    def item_detail(params)
        item = Item.find_by_id(params['id'])
        renderer = ERB.new(File.read("./views/show.erb"))
        renderer.result(binding)
    end

    def create_item_form
        categories = Category.find_all_categories
        renderer = ERB.new(File.read("./views/create.erb"))
        renderer.result(binding)
    end

    def update_item_form(params)
        item = Item.find_by_id(params['id'])
        categories = Category.find_all_categories
        renderer = ERB.new(File.read("./views/update.erb"))
        renderer.result(binding)
    end

    def create_item(params)
        item_id = params['id']
        name = params['name']
        price = params['price']
        category_id = params['category_id'].to_i

        category = Category.find_by_id(category_id)
        Item.create(name, price, category)
    end

    def update_item(params)
        item_id = params['id']
        name = params['name']
        price = params['price']
        category_id = params['category_id'].to_i

        category = Category.find_by_id(category_id)
        item = Item.find_by_id(item_id)
        item.update(name, price, category)
    end

    def delete_item(params)
        item = Item.find_by_id(params['id'])
        item.delete
    end
end
