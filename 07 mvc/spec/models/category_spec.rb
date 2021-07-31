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
        let(:db_connector) { double }

        context 'when parameters are valid' do
            let(:name) { "Street food" }

            it 'triggers category creation query' do
                expect(Category.client).to receive(:query)
                expect(Category.client).to receive(:last_id)

                category = Category.create(name)
                expect(category.name).to eq(name)
            end
        end

        context 'when parameters are invalid' do
            let(:name) { nil }

            it 'does not trigger category creation' do
                expect(Category.client).not_to receive(:query)

                category = Category.create(name)
                expect(category).to be(nil)
            end
        end
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
