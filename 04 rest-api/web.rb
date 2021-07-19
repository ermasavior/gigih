require 'sinatra'

get '/messages' do
    "Hello world"
end

items = []

get '/items' do
    items
end

post '/items' do
    item = params[:item]
    items.push(item)
end
