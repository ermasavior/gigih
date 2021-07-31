require_relative '../../controllers/category_controller'

RSpec.describe CategoryController do
    let(:category_controller) { CategoryController.new }
    let(:renderer) { double }
    let(:file) { double }

    describe '.category_detail' do
        let(:file_path) { "./views/categories/show.erb" }
        let(:category) { double }
        let(:params) { {'id'=> 4} }

        it 'triggers Category finder model' do
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

        it 'renders create form' do
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

        it 'triggers Category model finder' do
            expect(File).to receive(:read).with(file_path).and_return(file)
            expect(ERB).to receive(:new).with(file).and_return(renderer)
            expect(renderer).to receive(:result).with(Binding)

            expect(Category).to receive(:find_by_id).with(params['id'])
                .and_return(category)

            category_controller.update_category_form(params)
        end
    end

    describe '.create_category' do
        let(:category) { double }
        let(:params) { {'name'=> "main dish"} }

        it 'triggers Category creation' do
            expect(Category).to receive(:create).with(params['name'])
                .and_return(category)
            category_controller.create_category(params)
        end
    end

    describe '.update_category' do
        let(:category) { double }
        let(:params) { {'id'=>1, 'name'=> "main dish"} }

        it 'triggers Category creation' do
            expect(Category).to receive(:find_by_id).with(params['id'])
                .and_return(category)
            expect(category).to receive(:update).with(params['name'])
            category_controller.update_category(params)
        end
    end

    describe '.delete_category' do
        let(:category) { double }
        let(:params) { {'id'=>1} }

        it 'triggers Category creation' do
            expect(Category).to receive(:find_by_id).with(params['id'])
                .and_return(category)
            expect(category).to receive(:delete)
            category_controller.delete_category(params)
        end
    end
end
