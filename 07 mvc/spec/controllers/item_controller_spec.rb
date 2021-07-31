require_relative '../../controllers/item_controller'

RSpec.describe ItemController do
    let(:item_controller) { ItemController.new }
    let(:renderer) { double }
    let(:file) { double }

    describe '.list_items' do
        let(:file_path) { "./views/index.erb" }
        let(:items) { [ double ] }
        let(:categories) { [ double ] }

        it 'triggers data from Item & Category model' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            expect(Item).to receive(:find_all_items_with_category).and_return(items)
            expect(Category).to receive(:find_all_categories).and_return(categories)

            item_controller.list_items
        end
    end

    describe '.item_detail' do
        let(:file_path) { "./views/items/show.erb" }
        let(:item) { double }
        let(:params) { {'id'=> 12} }

        it 'triggers data from Item model' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            expect(Item).to receive(:find_by_id).with(params['id']).and_return(item)

            item_controller.item_detail(params)
        end
    end

    describe '.create_item_form' do
        let(:file_path) { "./views/items/create.erb" }
        let(:categories) { [ double ] }

        it 'triggers data from Item model' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            expect(Category).to receive(:find_all_categories).and_return(categories)

            item_controller.create_item_form
        end
    end

    describe '.update_item_form' do
        let(:file_path) { "./views/items/update.erb" }
        let(:item) { double }
        let(:categories) { [ double ] }
        let(:params) { {'id'=> 12} }

        it 'triggers data from Item model' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            expect(Item).to receive(:find_by_id).with(params['id']).and_return(item)
            expect(Category).to receive(:find_all_categories).and_return(categories)

            item_controller.update_item_form(params)
        end
    end

    describe '.create_item' do
        let(:id) { 12 }
        let(:name) { "Pisang" }
        let(:price) { 12000 }
        let(:category_id) { 4 }
        let(:params) {
            {
                'id'=>id, 'name'=>name, 'price'=>price, 'category_id'=>category_id
            }
        }
        let(:category) { double }
        let(:item) { double }

        it 'triggers Category finder and Item create' do
            expect(Category).to receive(:find_by_id).with(category_id)
                .and_return(category)
            expect(Item).to receive(:create).with(name, price, category)
                .and_return(item)

            item_controller.create_item(params)
        end
    end

    describe '.update_item' do
        let(:id) { 12 }
        let(:name) { "Pisang Madu" }
        let(:price) { 120000 }
        let(:category_id) { 4 }
        let(:params) {
            {
                'id'=>id, 'name'=>name, 'price'=>price, 'category_id'=>category_id
            }
        }
        let(:category) { double }
        let(:item) { double }

        it 'triggers Category finder and Item create' do
            expect(Category).to receive(:find_by_id).with(category_id)
                .and_return(category)
            expect(Item).to receive(:find_by_id).with(id)
                .and_return(item)
            expect(item).to receive(:update).with(name, price, category)

            item_controller.update_item(params)
        end
    end

    describe '.delete_item' do
        let(:params) { {'id'=> 12} }
        let(:item) { double }

        it 'triggers Item deletion' do
            expect(Item).to receive(:find_by_id).with(params['id'])
                .and_return(item)
            expect(item).to receive(:delete)

            item_controller.delete_item(params)
        end
    end
end
