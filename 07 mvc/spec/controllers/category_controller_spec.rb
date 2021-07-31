require_relative '../../controllers/category_controller'

RSpec.describe CategoryController do
    let(:category_controller) { CategoryController.new }
    let(:renderer) { double }
    let(:file) { double }

    describe '.category_detail' do
        let(:file_path) { "./views/categories/show.erb" }
        let(:category) { double }
        let(:params) { {'id'=> 4} }

        it 'triggers data from Item & Category model' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            expect(Category).to receive(:find_by_id_with_items).with(params['id'])
                .and_return(category)

            category_controller.category_detail(params)
        end
    end

    describe '.create_category_form' do
        let(:file_path) { "./views/categories/create.erb" }

        it 'triggers data from Item & Category model' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            category_controller.create_category_form
        end
    end

    describe '.update_category_form' do
        let(:file_path) { "./views/categories/update.erb" }
        let(:category) { double }
        let(:params) { {'id'=> 4} }

        it 'triggers data from Item & Category model' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            expect(Category).to receive(:find_by_id).with(params['id'])
                .and_return(category)

            category_controller.update_category_form(params)
        end
    end
end
