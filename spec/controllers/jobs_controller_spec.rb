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

    context "with valid job attributes" do
      context "with an invalid card" do
        let(:invalid_card) { credit_card.merge number: ' ' }

        it "doesn't create a new job" do
          expect do
            post :create, format: :js, job: job, credit_card: invalid_card
          end.to_not change(Job, :count)
        end
      end

      context "with a valid card" do
        def valid_request
          post :create, format: :js, job: job, credit_card: credit_card
        end
        let(:result) { double('Result').as_null_object }

        context "and a rejected transaction" do
          before do
            result.stub(:success?).and_return false
            CreditCard.any_instance.stub(:charge).and_return result
          end

          it "doesn't create a job" do
            expect { valid_request }.to_not change(Job, :count)
          end
        end
      end
    end
  end
end
