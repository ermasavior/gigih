require_relative '../../models/category'

RSpec.describe Category do
    describe '.valid?' do
        context 'when parameters are valid' do
            it 'returns true' do
                category = Category.new(id=1, name="Snack")
                expect(category.valid?).to be(true)
            end
        end

        context 'when parameters are invalid' do
            it 'returns false' do
                category = Category.new(id=1, name=nil)
                expect(category.valid?).to be(false)
            end
        end
    end

    describe '.create' do
    end

    describe '.update' do
    end

    describe '.find_by_id' do
    end

    describe '.find_by_id_with_items' do
    end

    describe '.find_all_categories' do
    end
end
