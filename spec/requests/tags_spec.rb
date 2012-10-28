require 'spec_helper'

describe "Tags" do

  describe "managing tags" do

    before do
      @post = create(:published_post)
      @user = create(:user)
      @tag = "test_tag"
      @another_tag = "second_test_tag"
    end

    context "as an unauthorized user" do

      before { visit edit_post_path(@post) }

      subject { page }

      it { should have_content "not authorized" } 
    end

    context "as an authorized user" do

      before do
        visit signin_path
        fill_in "username", with: @user.username
        fill_in "password", with: @user.password
        click_button "Sign in"
        click_link @post.title
      end
  
      describe "adding tags to a post" do

        before do
          fill_in 'post_tag_list', with: "#{@tag}, #{@another_tag}"
          click_button "Update"
        end

        subject { page }

        it "adds the tags" do
          @post.tag_list.should include @tag
          @post.tag_list.should include @another_tag
        end
      end

      describe "editing tags" do

        before do
          @new_tag = "new_tag"
          fill_in 'post_tag_list', with: @new_tag
          click_button "Update"
        end

        it "updates the associated tags" do
          @post.tag_list.should include @new_tag
          @post.tag_list.should_not include @tag
        end
      end

      describe "removing tags" do

        before do
          fill_in 'post_tag_list', with: ''
          click_button "Update"
        end

        it "removes the tag" do
          @post.tag_list.should_not include @tag
        end
      end
    end
  end

  describe "viewing tags" do

    before do
      @post = create(:published_post)
      @tag = "test_tag"
      @post.tag_list = @tag
      @post.save
    end

    describe "tags associated with a post" do

      before do
        visit post_path(@post.slug)
      end

      subject { page }

      it { should have_content "Tags" }
      it { should have_link @tag }
    end

    describe "viewing all posts associated with a tag" do

      before do
        visit post_path(@post.slug)
        click_link @tag
      end

      subject { page }

      it { should have_link @post.title }
      it { should have_content @tag }
    end

    describe "viewing all tags" do

      before do
        visit posts_path
        click_link "Tags"
      end

      subject { page }

      it { should have_link @tag }
    end
  end
end
