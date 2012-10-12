require 'spec_helper'

describe User do

  before do
    @user = User.new
    @user.username = 'testuser'
    @user.email = 'test@example.com'
    @user.password = 'foobarbaz'
    @user.save
  end

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
