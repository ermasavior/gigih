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
        let(:category) { Category.new(4, "snack") }

        context 'when parameters are valid' do
            let(:name) { "street food" }

            it 'triggers category update query' do
                expect(Category.client).to receive(:query)

                result = category.update(name)
                expect(result.name).to eq(name)
            end
        end

        context 'when parameters are invalid' do
            let(:name) { nil }

            it 'does not trigger category update' do
                expect(Category.client).not_to receive(:query)

                result = category.update(name)
                expect(result).to be(nil)
            end
        end
    end

    describe '.delete' do
        let(:items) { [double] }
        let(:category) { Category.new(4, "snack", items) }
        let(:item_category) { double }

        it 'triggers deletion query' do
            allow(ItemCategory).to receive(:new).with(items[0], category)
                .and_return(item_category)
            allow(item_category).to receive(:delete)

            expect(Category.client).to receive(:query)
            category.delete
        end

        context 'when category has items' do
            it 'triggers ItemCategory deletion' do
                expect(ItemCategory).to receive(:new).with(items[0], category)
                    .and_return(item_category)
                expect(item_category).to receive(:delete)

                category.delete
            end
        end

        context 'when category does not have items' do
            let(:items) { [] }

            it 'does not trigger ItemCategory deletion' do
                expect(ItemCategory).not_to receive(:new)

                category.delete
            end
        end
    end

    describe '.find_by_id' do
        let(:id) { Category.client.last_id }
        let(:name) { "Kue basah" }

        context 'when category is found' do
            before do
                Category.create("Kue basah")
            end

            it 'returns category' do
                category = Category.find_by_id(id)
                expect(category.id).to eq(id)
                expect(category.name).to eq(name)
            end

            after do
                Category.new(id, name).delete              
            end
        end

        context 'when category is not found' do
            it 'returns nil' do
                category = Category.find_by_id(id)
                expect(category).to be(nil)
            end
        end
    end

    describe '.find_by_id_with_items' do
    end

    describe '.find_all_categories' do
    end
end
