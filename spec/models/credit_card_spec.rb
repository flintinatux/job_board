require 'spec_helper'

describe CreditCard do
  before do
    @credit_card = CreditCard.new number: '4111111111111111',
                                  month:  '11',
                                  year:   '2015',
                                  postal_code: '30120',
                                  cvv:    '123'
  end

  subject { @credit_card }

  it { should respond_to :number }
  it { should respond_to :month }
  it { should respond_to :year }
  it { should respond_to :postal_code }
  it { should respond_to :cvv }
  it { should respond_to :charge }

  it { should be_valid }

  context "when number is blank" do
    before { subject.number = ' ' }
    it { should_not be_valid }
  end

  context "when month is blank" do
    before { subject.month = ' ' }
    it { should_not be_valid }
  end

  context "when year is blank" do
    before { subject.year = ' ' }
    it { should_not be_valid }
  end

  context "when postal_code is blank" do
    before { subject.postal_code = ' ' }
    it { should_not be_valid }
  end

  context "when cvv is blank" do
    before { subject.cvv = ' ' }
    it { should_not be_valid }
  end

  context "when expiration is not in the future" do
    before do
      date = 1.month.ago
      subject.month = date.month
      subject.year  = date.year
    end

    it { should_not be_valid }
  end
end
