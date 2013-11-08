# == Schema Information
#
# Table name: boards
#
#  id             :integer          not null, primary key
#  subdomain      :string(255)
#  title          :string(255)
#  tagline        :string(255)
#  icon           :string(255)
#  syndicates     :string(255)      default([])
#  suggestions    :string(255)
#  benefits       :text
#  price_cents    :integer          default(0), not null
#  price_currency :string(255)      default("USD"), not null
#  uuid           :string(36)       not null
#  created_at     :datetime
#  updated_at     :datetime
#

require 'spec_helper'

describe Board do
  before do
    @board = Board.new  subdomain:    'medical',
                        title:        'Medical Jobs',
                        tagline:      'Post your medical jobs here!',
                        icon:         'icon-user-md',
                        suggestions:  '"Nurse technician" or "Shot giver"',
                        benefits:     "**You want to post a job here.**\nThat's why.",
                        price:        '400.00'
  end

  subject { @board }

  it { should respond_to :subdomain }
  it { should respond_to :title }
  it { should respond_to :tagline }
  it { should respond_to :icon }
  it { should respond_to :syndicates }
  it { should respond_to :categories }
  it { should respond_to :suggestions }
  it { should respond_to :benefits }
  it { should respond_to :price }
  it { should respond_to :uuid }

  it { should be_valid }

  context "when subdomain is blank" do
    before { subject.subdomain = ' ' }
    it { should_not be_valid }
  end

  context "when title is blank" do
    before { subject.title = ' ' }
    it { should_not be_valid }
  end

  context "when tagline is blank" do
    before { subject.tagline = ' ' }
    it { should_not be_valid }
  end

  context "when suggestions is blank" do
    before { subject.suggestions = ' ' }
    it { should_not be_valid }
  end

  context "when benefits is blank" do
    before { subject.benefits = ' ' }
    it { should_not be_valid }
  end

  context "when it is persisted" do
    before { subject.save }

    it "includes the subdomain in the param" do
      subject.to_param.should =~ /#{subject.subdomain}/
    end
  end

  context "when subdomain is duplicate" do
    before { FactoryGirl.create :board, subdomain: subject.subdomain }
    it { should_not be_valid }
  end

  context "when price is <= 0" do
    before { subject.price = 0 }
    it { should_not be_valid }
  end
end
