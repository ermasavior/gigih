require 'mysql2'
require_relative 'item'
require_relative 'category'

def create_db_client
    Mysql2::Client.new(
        :host => "localhost",
        :username => "root",
        :password => "",
        :database => "food_oms_db"
    )
end

def get_all_items
    client = create_db_client
    raw_data = client.query("select * from items")
    items = Array.new
    raw_data.each do |data|
        item = Item.new(data["id"], data["name"], data["price"])
        items.push(item)
    end
    items
end

def get_all_categories
    client = create_db_client
    raw_data = client.query("select * from categories")
    categories = Array.new
    raw_data.each do |data|
        category = Category.new(data["id"], data["name"])
        categories.push(category)
    end
    categories
end

def get_all_items_with_categories
    client = create_db_client
    raw_data = client.query("select items.id, items.name as 'item_name', items.price, categories.name as 'category_name'
                  from items
                  left join item_categories on items.id = item_categories.item_id
                  left join categories on categories.id = item_categories.category_id")
    items = Array.new
    raw_data.each do |data|
        item = Item.new(data["id"], data["item_name"], data["price"], data["category_name"])
        items.push(item)
    end
    items
end

def get_items_cheaper_than(price)
    client = create_db_client
    client.query("select * from items where price < #{price}")
end

def insert_item(name, price)
    client = create_db_client
    client.query("insert into items (name, price) values ('#{name}', '#{price}')")
end

def insert_item_with_category(name, price, category_id)
    client = create_db_client
    client.query("insert into items (name, price) values ('#{name}', '#{price}')")

    if category_id != "0"
        item_id = client.last_id
        client.query("insert into item_categories (item_id, category_id) values ('#{item_id}', '#{category_id}')")
    end
end