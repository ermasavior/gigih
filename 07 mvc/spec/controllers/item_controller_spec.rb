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
end
