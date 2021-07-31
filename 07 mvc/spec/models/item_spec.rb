require_relative '../../models/item'
require_relative '../../models/category'

RSpec.describe Item do
    describe '.valid?' do
        context 'when parameters are valid' do
            it 'returns true' do
                item = Item.new(id=1, name="Pisang", price=20000)
                expect(item.valid?).to be(true)
            end
        end

        context 'when parameters are invalid' do
            it 'returns false' do
                item = Item.new(id=1, name=nil, price=nil)
                expect(item.valid?).to be(false)
            end
        end
    end

    describe '.update' do
        let(:item) { Item.new(1, "Supermie", 2000) }
        let(:id) { 1 }
        let(:name) { "Indomie" }
        let(:price) { 40000 }
        let(:category) { double }
        let(:item_category) { double }

        context 'when parameters are valid' do
            before do
                allow(ItemCategory).to receive(:find_by_item).with(item)
                    .and_return(item_category)
            end

            context 'when update category is nil' do
                let(:category) { nil }

                it 'returns updated item with no category' do
                    allow(item_category).to receive(:delete)

                    expect(Item.client).to receive(:query)
                    result = item.update(name, price, category)

                    expect(result.id).to eq(id)
                    expect(result.name).to eq(name)
                    expect(result.price).to eq(price)
                    expect(result.category).to be(category)
                end

                context 'when item has category before update' do
                    before do
                        item.category = double                
                        allow(Item.client).to receive(:query)
                    end

                    it 'triggers ItemCategory deletion' do
                        expect(item_category).to receive(:delete)
                        item.update(name, price, category)
                    end
                end

                context 'when item does not have category before update' do
                    let(:item_category) { nil }

                    before do
                        allow(Item.client).to receive(:query)
                    end
        
                    it 'does not trigger item_category deletion' do
                        expect(item_category).not_to receive(:delete)
                        item.update(name, price, category)
                    end
                end
            end

            context 'when update category is not nil' do
                it 'returns item with new category' do
                    allow(item_category).to receive(:update)

                    expect(Item.client).to receive(:query)
                    result = item.update(name, price, category)
        
                    expect(result.id).to eq(id)
                    expect(result.name).to eq(name)
                    expect(result.price).to eq(price)
                    expect(result.category).to be(category)
                end

                context 'when item has category before update' do
                    before do
                        item.category = double
                        allow(Item.client).to receive(:query)
                    end

                    it 'triggers ItemCategory update' do
                        expect(item_category).to receive(:update)
                        item.update(name, price, category)
                    end
                end

                context 'when item does not have category before update' do
                    let(:item_category) { nil }

                    before do
                        allow(Item.client).to receive(:query)
                    end

                    it 'triggers ItemCategory creation' do
                        expect(ItemCategory).to receive(:create)
                        item.update(name, price, category)
                    end
                end
            end
        end

        context 'when parameters are invalid' do
            let(:name) { nil }
            let(:price) { nil }

            it 'returns nil and does not trigger db' do
                item = Item.new(id, name, price)

                expect(Item.client).not_to receive(:query)
                result = item.update(name, price, category)
                expect(result).to eq(nil)
            end
        end
    end

    describe '.delete' do
        let(:item) { Item.new(1, "Supermie", 2000) }
        let(:item_category) { double }

        before do
            allow(ItemCategory).to receive(:find_by_item).with(item)
                .and_return(item_category)
        end

        it 'triggers deletion query' do
            allow(item_category).to receive(:delete)

            expect(Item.client).to receive(:query)
            item.delete
        end

        context 'when item has category before deletion' do
            it 'triggers item_category deletion' do
                expect(Item.client).to receive(:query)
                expect(item_category).to receive(:delete)
                item.delete
            end
        end

        context 'when item does not have category before deletion' do
            let(:item_category) { nil }

            before do
                expect(Item.client).to receive(:query)
            end

            it 'does not trigger item_category deletion' do
                expect(item_category).not_to receive(:delete)
                item.delete
            end
        end
    end

    describe '.create' do
        let(:id) { 1 }
        let(:name) { "Indomie" }
        let(:price) { 40000 }
        let(:category) { double }
        let(:db_connector) { double }

        context 'when parameters are valid' do
            context 'when create category is nil' do
                it 'triggers item creation query' do
                    expect(Item.client).to receive(:query).once
                    expect(Item.client).to receive(:last_id)

                    result = Item.create(name, price)
                end

                it 'creates item with no category' do
                    allow(Item.client).to receive(:query)
                    allow(Item.client).to receive(:last_id)

                    result = Item.create(name, price)

                    expect(result.name).to eq(name)
                    expect(result.price).to eq(price)
                    expect(result.category).to be(nil)
                end
            end

            context 'when create category is not nil' do
                it 'triggers ItemCategory creation' do            
                    allow(Item.client).to receive(:query)
                    allow(Item.client).to receive(:last_id)

                    expect(ItemCategory).to receive(:create)
                    result = Item.create(name, price, category)
                end

                it 'creates item with category' do
                    allow(ItemCategory).to receive(:create)        
                    expect(Item.client).to receive(:query).once
                    expect(Item.client).to receive(:last_id)

                    result = Item.create(name, price, category)
                    expect(result.name).to eq(name)
                    expect(result.price).to eq(price)
                    expect(result.category).to eq(category)
                end
            end
        end

        context 'when parameters are invalid' do
            let(:name) { nil }
            let(:price) { nil }

            it 'does not create item' do
                expect(Item.client).not_to receive(:query)
                Item.create(name, price, category)
            end
        end
    end

    describe '.find_by_id' do
        let(:name) { "Gulali" }
        let(:price) { 5000 }

        context 'when item is found' do
            context 'when item has category' do
                let(:category) { Category.find_by_id(1) }
                let(:item) { Item.create(name, price, category) }

                before do
                    item
                end

                it 'returns item with category' do
                    result = Item.find_by_id(item.id)

                    expect(result.name).to eq(name)
                    expect(result.price).to eq(price)
                    expect(result.category.id).to eq(category.id)
                end
                
                after do
                    item.delete
                end
            end

            context 'when item does not have category' do
                let(:item) { Item.create(name, price) }

                before do
                    item
                end

                it 'returns item with no category' do
                    result = Item.find_by_id(item.id)

                    expect(result.name).to eq(name)
                    expect(result.price).to eq(price)
                    expect(result.category).to be(nil)
                end

                after do
                    item.delete
                end
            end
        end

        context 'when is not found' do
            let(:id) { -1 }

            it 'returns nil' do
                result = Item.find_by_id(id)
                expect(result).to be(nil)
            end
        end
    end

    describe '.find_by_category' do
        context 'when category is valid' do
            let(:category) { Category.find_by_id(1) }
            let(:items) { Item.client.query("select * from items left join item_categories on items.id=item_categories.item_id where category_id=1") }

            it 'returns item with its category' do
                results = Item.find_by_category(category)
                results.zip(items) do |result, item|
                    expect(result.name).to eq(item["name"])
                    expect(result.price).to eq(item["price"])
                    expect(result.category.id).to eq(item["category_id"])
                end
            end
        end

        context 'when category is invalid' do
            let(:category) { nil }

            it 'returns empty array' do
                items_result = Item.find_by_category(category)
                expect(items_result).to eq([])
            end
        end
    end

    describe '.find_all_items_with_category' do
        let(:items) { Item.client.query("select * from items left join item_categories on items.id=item_categories.item_id") }

        it 'returns items with its category' do
            results = Item.find_all_items_with_category
            results.zip(items) do |result, item|
                expect(result.name).to eq(item["name"])
                expect(result.price).to eq(item["price"])
                expect(result.category.id).to eq(item["category_id"]) unless result.category.nil?
            end
        end
    end
end
