require 'sinatra'
require_relative 'controllers/item_controller'
require_relative 'models/item'
require_relative 'models/category'

item_controller = ItemController.new

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
