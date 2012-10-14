# == Schema Information
#
# Table name: users
#
#  id               :integer          not null, primary key
#  username         :string(255)      not null
#  email            :string(255)
#  crypted_password :string(255)
#  salt             :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'spec_helper'

describe User do

  before { @user = create(:user) }

  subject { @user }

  it { should be_valid }

  it { should respond_to :username }
  it { should respond_to :email }
  it { should respond_to :password }

  describe "when username is not valid" do
    before { @user.username = '' }
    it { should_not be_valid }
  end

  describe "when email is not valid" do
    before { @user.email = '' }
    it { should_not be_valid }
  end
end
