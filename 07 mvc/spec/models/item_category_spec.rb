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
    end

    describe '.delete' do
    end

    describe '.create' do
    end

    describe '.find_by_item' do
    end
end
