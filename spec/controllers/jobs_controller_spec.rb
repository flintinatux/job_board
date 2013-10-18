require 'spec_helper'

describe JobsController do
  let(:job)         { FactoryGirl.attributes_for :job }
  let(:credit_card) { FactoryGirl.attributes_for :credit_card }

  describe 'POST #create' do

    context "with invalid job attributes" do
      let(:invalid_job) { job.merge title: ' ' }

      it "doesn't create a new job" do
        expect do
          post :create, format: :js, job: invalid_job, credit_card: credit_card
        end.to_not change(Job, :count)
      end
    end

    context "with a valid card" do
      before do
        post :create, format: :js, job: job, credit_card: credit_card
      end

      it "creates the job" do

      end
    end
  end
end
