# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'spec_helper'

describe User do

  let(:user) { create(:user) }
  let(:dup_user) { user.dup }

  subject { user }

  it { should be_valid }

  it { should respond_to :username }
  it { should respond_to :password }

  specify "when username is not unique" do
    dup_user.should_not be_valid
  end

  describe "when username is blank" do
    before { user.username = '' }
    it { should_not be_valid }
  end

  describe "when password is blank" do
    before { user.password = '' }
    it { should_not be_valid }
  end

  describe "when username is too short" do
    before { user.username = "foo" }
    it { should_not be_valid }
  end

  describe "when username is too long" do
    before { user.username = "foobarbazwhizbang" }
    it { should_not be_valid }
  end

  describe "when password is too short" do
    before { user.password = "foo" }
    it { should_not be_valid }
  end
end
