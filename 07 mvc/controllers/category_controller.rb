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

    def create_category(params)
        Category.create(params['name'])
    end
end