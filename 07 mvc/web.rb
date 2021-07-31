require 'sinatra'
require_relative 'controllers/item_controller'
require_relative 'controllers/category_controller'

item_controller = ItemController.new
category_controller = CategoryController.new

get '/' do
    item_controller.list_items
end

get '/items/:id/show' do
    item_controller.item_detail(params)
end

get '/items/new' do
    item_controller.create_item_form
end

get '/items/:id/edit' do
    item_controller.update_item_form(params)
end

post '/items/create' do
    item_controller.create_item(params)
    redirect '/'
end

post '/items/:id/update' do
    item_controller.update_item(params)
    redirect '/'
end

post '/items/:id/delete' do
    item_controller.delete_item(params)
    redirect '/'
end

get '/categories/:id/show' do
    category_controller.category_detail(params)
end

get '/categories/new' do
    category_controller.create_category_form
end

get '/categories/:id/edit' do
    category_controller.update_category_form(params)
end

post '/categories/create' do
    category_controller.create_category(params)
    redirect '/'
end

post '/categories/:id/update' do
    category_controller.update_category(params)
    redirect '/'
end

post '/categories/:id/delete' do
    category_controller.delete_category(params)
    redirect '/'
end
