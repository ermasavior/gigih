require_relative '../models/category'

class CategoryController
    def category_detail(params)
        category = Category.find_by_id_with_items(params['id'])
        renderer = ERB.new(File.read("./views/categories/show.erb"))
        renderer.result(binding)
    end

    def create_category_form
        renderer = ERB.new(File.read("./views/categories/create.erb"))
        renderer.result(binding)
    end

    def update_category_form(params)
        category = Category.find_by_id(params['id'])
        renderer = ERB.new(File.read("./views/categories/update.erb"))
        renderer.result(binding)
    end

    def create_category(params)
        Category.create(params['name'])
    end

    def update_category(params)
        category = Category.find_by_id(params['id'])
        category.update(params['name'])
    end
end