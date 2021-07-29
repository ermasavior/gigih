require 'sinatra'
require_relative 'models/item'
require_relative 'models/category'

get '/' do
    items = Item.find_all_items_with_category
    erb :index, locals: {
        items: items
    }
end

get '/items/:id/show' do
    item = Item.find_by_id(params['id'])
    erb :show, locals: {
        item: item
    }
end

get '/items/new' do
    categories = Category.find_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/create' do
    name =  params['name']
    price =  params['price']
    category_id = params['category_id'].to_i

    category = Category.find_by_id(category_id)
    Item.create(name, price, category)

    redirect '/'
end