require 'spec_helper'

describe BoardsController do
  context "with existing boards" do
    let!(:boards) { 3.times.map { FactoryGirl.create :board } }

    describe 'GET #index' do
      before { get :index }

      it "loads all the boards" do
        assigns(:boards).should eq boards
      end
    end
  end

  let(:valid_attributes)   { FactoryGirl.attributes_for :board }
  let(:invalid_attributes) { valid_attributes.merge title: ' ' }

  describe 'POST #create' do
    context "with valid atttributes" do
      it "creates a new board" do
        expect { post :create, format: :js, board: valid_attributes }.to change(Board, :count).by(1)
      end
    end

    context "with invalid atttributes" do
      it "doesn't create a new board" do
        expect { post :create, format: :js, board: invalid_attributes }.to_not change(Board, :count)
      end
    end
  end

  context "with an existing board" do
    let!(:board) { FactoryGirl.create :board }

    describe 'GET #edit' do
      before { get :edit, id: board.id }

      it "finds the right board" do
        assigns(:board).should eq board
      end
    end

    describe 'GET #update' do
      context "with valid_attributes" do
        let(:new_title) { 'New jobs for you' }
        before do
          patch :update, format: :js, id: board.id, board: { title: new_title }
        end

        it "updates the board" do
          Board.find(board.id).title.should eq new_title
        end
      end

      context "with invalid_attributes" do
        before do
          patch :update, format: :js, id: board.id, board: { title: ' ' }
        end

        it "doesn't update the board" do
          assigns(:board).should_not be_valid
        end
      end
    end

    describe 'DELETE #destroy' do
      it "deletes the board" do
        expect { delete :destroy, format: :js, id: board.id }.to change(Board, :count).by(-1)
      end
    end
  end
end
