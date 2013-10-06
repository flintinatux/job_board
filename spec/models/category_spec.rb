# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  board_id   :integer
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Category do
  let(:board) { FactoryGirl.create :board }
  before do
    @category = board.categories.build name: 'category name'
  end

  subject { @category }

  it { should respond_to :board }
  it { should respond_to :name }
  it { should respond_to :jobs }

  it { should be_valid }

  describe "when name is blank" do
    before { subject.name = ' ' }
    it { should_not be_valid }
  end

  context "when persisted" do
    before { subject.save }

    it "includes the name in the param" do
      subject.to_param.should =~ /#{subject.name.parameterize}/
    end
  end
end
