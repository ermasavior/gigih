require 'sinatra'
require_relative 'db_connector'

get '/' do
    items = get_all_items_with_categories
    erb :index, locals: {
        items: items
    }
end

get '/items/:id/show' do
    item = get_item_with_category(params['id'])
    erb :show, locals: {
        item: item
    }
end

get '/items/:id/edit' do
    item = get_item_with_category(params['id'])
    categories = get_all_categories

    erb :update, locals: {
        item: item, categories: categories
    }
end

get '/items/new' do
    categories = get_all_categories
    erb :create, locals: {
        categories: categories
    }
end

post '/items/create' do
    name =  params['name']
    price =  params['price']
    category_id = params['category_id'].to_i

    insert_item_with_category(name, price, category_id)
    redirect '/'
end

post '/items/:id/update' do
    item_id = params['id']
    name = params['name']
    price = params['price']
    category_id = params['category_id'].to_i

    update_item_with_category(item_id, name, price, category_id)
    redirect '/'
end

post '/items/:id/delete' do
    item_id = params['id']
    delete_item_with_category(item_id)
    redirect '/'
end
