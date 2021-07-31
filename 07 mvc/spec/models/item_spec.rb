require_relative '../../models/item'

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
        let(:db_connector) { double }

        before do
            allow(Model).to receive(:client).and_return(db_connector)
        end

        context 'when parameters are valid' do
            before do
                allow(db_connector).to receive(:query).and_return(double)
                allow(ItemCategory).to receive(:find_by_item).with(item)
                    .and_return(item_category)
            end

            context 'when update category is nil' do
                let(:category) { nil }

                it 'returns updated item with no category' do
                    allow(item_category).to receive(:delete)
                    expect(db_connector).to receive(:query)

                    result = item.update(name, price, category)
                    expected_result = Item.new(id, name, price)

                    expect(result.id).to eq(expected_result.id)
                    expect(result.name).to eq(expected_result.name)
                    expect(result.price).to eq(expected_result.price)
                    expect(result.category).to be(category)
                end

                context 'when item has category before update' do
                    before do
                        item.category = double
                    end

                    it 'triggers ItemCategory deletion' do
                        expect(item_category).to receive(:delete)
                        item.update(name, price, category)
                    end
                end

                context 'when item does not have category before update' do
                    let(:item_category) { nil }
        
                    it 'does not trigger item_category deletion' do
                        expect(item_category).not_to receive(:delete)
                        item.update(name, price, category)
                    end
                end
            end

            context 'when update category is not nil' do
                it 'returns item with new category' do
                    allow(item_category).to receive(:update)

                    result = item.update(name, price, category)
                    expected_result = Item.new(id, name, price, category)
        
                    expect(result.id).to eq(expected_result.id)
                    expect(result.name).to eq(expected_result.name)
                    expect(result.price).to eq(expected_result.price)
                    expect(result.category).to be(category)
                end

                context 'when item has category before update' do
                    before do
                        item.category = double
                    end

                    it 'triggers ItemCategory update' do
                        expect(item_category).to receive(:update)
                        item.update(name, price, category)
                    end
                end

                context 'when item does not have category before update' do
                    let(:item_category) { nil }

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

                expect(db_connector).not_to receive(:query)
                result = item.update(name, price, category)
                expect(result).to eq(nil)
            end
        end
    end

    describe '.delete' do
        let(:item) { Item.new(1, "Supermie", 2000) }
        let(:item_category) { double }
        let(:db_connector) { double }

        before do
            allow(ItemCategory).to receive(:find_by_item).with(item)
                .and_return(item_category)
            allow(Model).to receive(:client).and_return(db_connector)
        end

        it 'triggers deletion query' do
            allow(item_category).to receive(:delete)

            expect(db_connector).to receive(:query)
            item.delete
        end

        context 'when item has category before deletion' do
            before do
                expect(db_connector).to receive(:query)
            end

            it 'triggers item_category deletion' do
                expect(item_category).to receive(:delete)
                item.delete
            end
        end

        context 'when item does not have category before deletion' do
            let(:item_category) { nil }

            before do
                expect(db_connector).to receive(:query)
            end

            it 'does not trigger item_category deletion' do
                expect(item_category).not_to receive(:delete)
                item.delete
            end
        end
    end
end
