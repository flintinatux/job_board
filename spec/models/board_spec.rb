# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  subdomain  :string(255)
#  title      :string(255)
#  tagline    :string(255)
#  icon       :string(255)
#  syndicates :string(255)      default([])
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Board do
  before do
    @board = Board.new  subdomain: 'medical',
                        title:     'Medical Jobs',
                        tagline:   'Post your medical jobs here!',
                        icon:      'icon-user-md'
  end

  subject { @board }

  it { should respond_to :subdomain }
  it { should respond_to :title }
  it { should respond_to :tagline }
  it { should respond_to :icon }
  it { should respond_to :syndicates }
  it { should respond_to :categories }

  it { should be_valid }

  describe "when subdomain is blank" do
    before { subject.subdomain = ' ' }
    it { should_not be_valid }
  end

  describe "when title is blank" do
    before { subject.title = ' ' }
    it { should_not be_valid }
  end

  describe "when tagline is blank" do
    before { subject.tagline = ' ' }
    it { should_not be_valid }
  end

  describe "when it is persisted" do
    before { subject.save }

    it "includes the subdomain in the param" do
      subject.to_param.should =~ /#{subject.subdomain}/
    end
  end

  describe "when subdomain is duplicate" do
    before { FactoryGirl.create :board, subdomain: subject.subdomain }
    it { should_not be_valid }
  end
end
