# == Schema Information
#
# Table name: jobs
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  category_id  :integer
#  location     :string(255)
#  description  :text
#  instructions :string(255)
#  expires_at   :datetime
#  highlight    :boolean
#  company      :string(255)
#  url          :string(255)
#  email        :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#

require 'spec_helper'

describe Job do
  let(:title) { 'A job' }
  let(:company) { Faker::Company.name }
  let(:url) { "http://www.#{company.gsub(/\W/,'').underscore.dasherize}.com" }
  let(:category) { FactoryGirl.create :category }
  before do
    @job = category.jobs.build  title:        title,
                                location:     'Anywhere',
                                description:  'Making widgets'*100,
                                instructions: 'Email somebody',
                                company:      company,
                                url:          url,
                                email:        Faker::Internet.email
  end

  subject { @job }

  it { should respond_to :title }
  it { should respond_to :category }
  it { should respond_to :location }
  it { should respond_to :description }
  it { should respond_to :instructions }
  it { should respond_to :expires_at }
  it { should respond_to :highlight }
  it { should respond_to :company }
  it { should respond_to :url }
  it { should respond_to :email }
  it { should respond_to :uuid }

  it { should be_valid }

  describe "when title is blank" do
    before { subject.title = ' ' }
    it { should_not be_valid }
  end

  describe "when location is blank" do
    before { subject.location = ' ' }
    it { should_not be_valid }
  end

  describe "when description is blank" do
    before { subject.description = ' ' }
    it { should_not be_valid }
  end

  describe "when instructions is blank" do
    before { subject.instructions = ' ' }
    it { should_not be_valid }
  end

  describe "when company is blank" do
    before { subject.company = ' ' }
    it { should_not be_valid }
  end

  describe "when email is blank" do
    before { subject.email = ' ' }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        subject.email = invalid_address
        subject.should_not be_valid
      end
    end
  end

  describe "when url is invalid" do
    before { subject.url = 'htp://somname.com#uhhuh/' }
    it { should_not be_valid }
  end

  describe "when initialized" do
    it "sets :highlight to false by default" do
      subject.highlight.should eq false
    end

    it "sets expires_at to some time later than now" do
      subject.expires_at.should > Time.now
    end
  end

  describe "when persisted" do
    before { subject.save }

    it "includes the title in the param" do
      subject.to_param.should =~ /#{title.parameterize}/
    end
  end
end
