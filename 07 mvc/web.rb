require 'sinatra'
require_relative 'models/item'

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
