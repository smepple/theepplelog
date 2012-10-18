require 'spec_helper'

describe "Authentication" do

  let(:user) { create(:user) }

  before { visit signin_path }

  subject { page }

  describe "signin page" do
    it { should have_content "Sign in" }
    it { should have_selector 'input', placeholder: "Enter username" }
    it { should have_selector 'input', placeholder: "Enter password" }
  end

  describe "successful signin" do

    before do
      fill_in "username", with: user.username
      fill_in "password", with: user.password
      click_button "Sign in"
    end

    it "logs the user in" do
      page.should have_link "Sign out"
    end

    describe "redirects to the admin page" do
      it { should have_content "logged in" }
      it { should have_content "Drafts" }
      it { should have_content "Published" }
      it { should have_link "Home" }
      it { should have_link "New post" }
    end
  end

  describe "unsuccessful signin" do

    before do
      fill_in "username", with: ''
      fill_in "password", with: ''
      click_button "Sign in"
    end

    it "displays an error message" do
      page.should have_content "Username or password is invalid"
    end

    it "leaves the user on the signin page" do
      page.should have_content "Sign in"
    end
  end
end
