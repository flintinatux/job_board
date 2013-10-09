require 'spec_helper'

describe JobsController do
  let(:title) { 'Job title' }
  let(:valid_attributes) { FactoryGirl.attributes_for :job }

  describe 'POST #preview' do
    before { post :preview, job: valid_attributes.merge(title: title) }

    it "builds a job with the given attributes" do
      assigns(:job).title.should eq title
    end
  end
end
