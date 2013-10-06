require 'spec_helper'

describe CategoriesController do
  before do
    sign_in FactoryGirl.create(:user)
  end

  let!(:board)              { FactoryGirl.create :board }
  let(:valid_attributes)    { FactoryGirl.attributes_for :category }
  let(:invalid_attributes)  { valid_attributes.merge name: ' ' }

  describe 'POST #create' do
    context "with valid_attributes" do
      it "creates a new post" do
        expect { post :create, format: :js, board_id: board.id, category: valid_attributes }.to change(Category, :count).by(1)
      end
    end

    context "with invalid_attributes" do
      it "creates a new post" do
        expect { post :create, format: :js, board_id: board.id, category: invalid_attributes }.to_not change(Category, :count)
      end
    end
  end

  context "with an existing category" do
    let!(:category) { FactoryGirl.create :category, board: board }

    describe 'GET #edit' do
      before { get :edit, board_id: board.id, id: category.id }
      it "finds the correct category" do
        assigns(:category).should eq category
      end
    end

    describe 'PATCH #update' do
      let(:new_name) { 'new category name' }

      context "with valid_attributes" do
        before do
          patch :update, format: :js, board_id: board.id, id: category.id, category: { name: new_name }
        end

        it "updates the category" do
          Category.find(category.id).name.should eq new_name
        end
      end

      context "with invalid_attributes" do
        before do
          patch :update, format: :js, board_id: board.id, id: category.id, category: { name: ' ' }
        end

        it "doesn't update the category" do
          assigns(:category).should_not be_valid
        end
      end
    end

    describe 'DELETE #destroy' do
      it "deletes the category" do
        expect do
          delete :destroy, format: :js, board_id: board.id, id: category.id
        end.to change(Category, :count).by(-1)
      end
    end
  end
end
