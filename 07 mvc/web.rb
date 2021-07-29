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

get '/items/:id/edit' do
    item = Item.find_by_id(params['id'])
    categories = Category.find_all_categories

    erb :update, locals: {
        item: item, categories: categories
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

post '/items/:id/update' do
    item_id = params['id']
    name = params['name']
    price = params['price']
    category_id = params['category_id'].to_i

    category = Category.find_by_id(category_id)

    item = Item.find_by_id(item_id)
    item.update(name, price, category)

    redirect '/'
end