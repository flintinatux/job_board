# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

require 'spec_helper'

describe User do
  before do
    @user = User.new name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar"
  end

  subject { @user }

  it { should respond_to :name }
  it { should respond_to :email }
  it { should respond_to :password_digest }
  it { should respond_to :password }
  it { should respond_to :password_confirmation }
  it { should respond_to :remember_token }
  it { should respond_to :authenticate }

  it { should be_valid }

  describe "when name is not present" do
    before { subject.name = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { subject.email = " " }
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

  describe "when email address is already taken" do
    before do
      user_with_same_email = subject.dup
      user_with_same_email.email = subject.email.upcase
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAMPLe.CoM" }

    it "should be saved as all lower-case" do
      subject.email = mixed_case_email
      subject.save
      subject.reload.email.should == mixed_case_email.downcase
    end
  end

  describe "with a password that's too short" do
    before { subject.password = subject.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { subject.save }
    let(:found_user) { User.find_by email: subject.email }

    describe "with valid password" do
      it { should == found_user.authenticate(subject.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end
end
