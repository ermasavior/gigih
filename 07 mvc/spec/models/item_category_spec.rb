require_relative '../../models/item_category'
require_relative '../../models/item'
require_relative '../../models/category'

RSpec.describe ItemCategory do
    describe '.valid?' do
        context 'when parameters are valid' do
            let(:item) { Item.new(100, "Sate", 2000) }
            let(:category) { Category.new(1, "main dish") }

            it 'returns true' do
                item_category = Category.new(item, category)
                expect(item_category.valid?).to be(true)
            end
        end

        context 'when parameters are invalid' do
            let(:item) { nil }
            let(:category) { nil }

            it 'returns false' do
                item_category = Category.new(item, category)
                expect(item_category.valid?).to be(false)
            end
        end
    end

    describe '.update' do
        let(:item) { Item.new(100, "Sate", 2000) }
        let(:category) { Category.new(1, "main dish") }
        let(:item_category) { ItemCategory.new(item, category) }

        context 'when parameters are valid' do
            let(:update_category) { Category.new(2, "beverage") }

            it 'triggers update query' do
                expect(ItemCategory.client).to receive(:query)
                item_category.update(item, update_category)
                expect(item_category.item).to eq(item)
                expect(item_category.category).to eq(update_category)
            end
        end

        context 'when parameters are invalid' do
            let(:update_category) { nil }
            
            it 'does not trigger update query' do
                expect(ItemCategory.client).not_to receive(:query)
                item_category.update(item, update_category)
            end
        end
    end

    describe '.delete' do
    end

    describe '.create' do
    end

    describe '.find_by_item' do
    end
end
