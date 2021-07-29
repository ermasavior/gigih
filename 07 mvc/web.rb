require 'sinatra'
require_relative 'models/item'

get '/' do
    items = Item.find_all_items_with_category
    erb :index, locals: {
        items: items
    }
end
