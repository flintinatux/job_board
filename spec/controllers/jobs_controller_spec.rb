require 'spec_helper'

describe JobsController do
  let(:board)      { FactoryGirl.create :board }
  let(:categories) { 3.times.map { FactoryGirl.create :category, board: board } }
  let(:category)   { categories.first }
  let(:job)        { FactoryGirl.attributes_for(:job).merge category_id: category.id }
  let(:card)       { FactoryGirl.attributes_for :card }

  describe 'GET #index' do
    let!(:categories_with_jobs) { categories[0,2] }
    let!(:jobs) do
      categories_with_jobs.map do |category|
        FactoryGirl.create :job, category: category
      end
    end

    before { get :index, subdomain: board.subdomain }

    it "loads the jobs for all categories" do
      assigns(:jobs).should eq jobs.sort_by(&:created_at).reverse
    end

    it "loads the categories with jobs" do
      assigns(:categories).should eq categories_with_jobs.sort_by(&:updated_at).reverse
    end

    it "totals the jobs for each category" do
      assigns(:total_jobs).should == { 1 => 1, 2 => 1 }
    end

    context "for specific category" do
      before { get :index, subdomain: board.subdomain, category_id: category.id }

      it "finds the correct category" do
        assigns(:categories).should eq [category]
      end

      it "loads the jobs for that one category" do
        assigns(:jobs).should eq jobs.select { |job| job.category_id == category.id }
      end

      it "totals the jobs for that one category" do
        assigns(:total_jobs).should == { 1 => 1 }
      end
    end
  end

  # TODO: testing search in an in-memory sqlite3 db doesn't work,
  #       since full-text search is a postgresql feature.
  #
  # describe 'GET #search' do
  #   let(:search_term) { ' An odd turn of phrase.'}
  #   let!(:jobs) do
  #     categories.map do |category|
  #       FactoryGirl.create :job, category: category
  #     end.tap do |jobs|
  #       jobs[1].description << search_term
  #       jobs[1].save
  #     end
  #   end
  #
  #   it "finds the jobs with the provided search term" do
  #     assigns(:jobs).should eq jobs[1]
  #   end
  # end

  describe 'GET #show' do
    let!(:this_job) { FactoryGirl.create :job, category: category }

    before do
      get :show, subdomain: board.subdomain, category_id: category.id, id: this_job.id
    end

    it "finds the correct category" do
      assigns(:category).should eq category
    end

    it "finds the correct job" do
      assigns(:job).should eq this_job
    end
  end

  describe 'POST #create' do

    context "with invalid job attributes" do
      let(:invalid_job) { job.merge title: ' ' }

      it "doesn't create a new job" do
        expect do
          post :create, format: :js, subdomain: board.subdomain, job: invalid_job, card: card
        end.to_not change(Job, :count)
      end
    end

    context "with valid job attributes" do
      context "with an invalid card" do
        let(:invalid_card) { card.merge number: ' ' }

        it "doesn't create a new job" do
          expect do
            post :create, format: :js, subdomain: board.subdomain, job: job, card: invalid_card
          end.to_not change(Job, :count)
        end
      end

      context "with a valid card" do
        def valid_request
          post :create, format: :js, subdomain: board.subdomain, job: job, card: card
        end
        let(:result) { double('Result').as_null_object }

        context "and a rejected transaction" do
          before do
            result.stub(:success?).and_return false
            Card.any_instance.stub(:charge).and_return result
          end

          it "doesn't create a job" do
            expect { valid_request }.to_not change(Job, :count)
          end
        end

        context "and a successful transaction" do
          before do
            result.stub(:success?).and_return true
            Card.any_instance.stub(:charge).and_return result
          end

          it "creates a job" do
            expect { valid_request }.to change(Job, :count).by(1)
          end
        end
      end
    end
  end
end
