require 'spec_helper'

describe "Posts" do
  
  describe "index page" do

    before { visit posts_path }

    subject { page }

    it { should have_content "About" }
    it { should have_content "Archive" }
    it { should have_content "RSS" }

    context "with published posts" do
      describe "it should display all posts" do
        before do
          @first_post = create(:published_post)
          @second_post = create(:published_post)
          visit posts_path
        end

        it { should have_content @first_post.title }
        it { should have_content @second_post.title }
      end
    end

    context "without any published posts" do
      describe "there should be placeholder text" do
        before { visit posts_path }

        it { should have_content "Welcome! More content coming soon." }
      end

      describe "it doesn't display drafts" do
        before do
          @draft = create(:post)
          visit posts_path
        end

        it { should_not have_content @draft.title }
      end
    end

    # TODO: test infinite scroll
    # TODO: test comment count display
  end

  describe "admin page" do

    context "as an unauthorized user" do

      before { visit admin_path }

      subject { page }

      it { should have_content "not authorized" }
    end

    context "as an authorized user" do

      before do
        @user = create(:user)
        visit signin_path
        fill_in "username", with: @user.username
        fill_in "password", with: @user.password
        click_button "Sign in"
      end

      subject { page }

      it { should have_content "Drafts" }
      it { should have_content "Published" }
      it { should have_link "Home" }
      it { should have_link "New post" }
      it { should have_link "Sign out" }

      describe "it lists all drafts" do

        before do
          @first_post = create(:post)
          @second_post = create(:post)
          visit admin_path
        end

        it { should have_content @first_post.title }
        it { should have_content @second_post.title }
      end

      describe "it lists all published posts" do

        before do
          @first_published = create(:published_post)
          @second_published = create(:published_post)
          visit admin_path
        end

        it { should have_content @first_published.title }
        it { should have_content @second_published.title }
      end
    end
  end

  describe "new post page" do

    context "as an unauthorized user" do

      before { visit new_post_path }

      subject { page }

      it { should have_content "not authorized" }
    end

    context "as an authorized user" do

      before do
        @user = create(:user)
        visit signin_path
        fill_in "username", with: @user.username
        fill_in "password", with: @user.password
        click_button "Sign in"
        click_link "New post"
      end

      subject { page }

      it { should have_content "New post" }
      it { should have_selector 'input', placeholder: "title" }
      it { should have_selector 'textarea', placeholder: "Start writing" }
      it { should have_selector 'input', value: "Create post" }
      it { should have_link 'Cancel' }

      describe "creating a post" do

        context "with valid attributes" do

          before do
            fill_in "post_title", with: "Dolor sit amet"
            fill_in "post_content", with: "Morbi leo risus, porta ac consectetur ac, vestibulum at eros."
          end

          it "creates a post" do
            expect { click_button "Create Post" }.to change(Post, :count).by(1)
          end
        end

        context "with invalid attributes" do

          before do
            fill_in "post_title", with: ''
            fill_in "post_content", with: ''
          end

          it "doesn't create a post" do
            expect { click_button "Create Post" }.not_to change(Post, :count).by(1)
          end

          describe "it displays error messages" do
            before { click_button "Create Post" }

            it { should have_content "errors" }
            it { should have_content "can't be blank" }
          end
        end
      end
    end
  end

  describe "edit post page" do

    context "as an unauthorized user" do

      before do
        @post = create(:post)
        visit edit_post_path(@post)
      end

      subject { page }

      it { should have_content "not authorized" }
    end

    context "as an authorized user" do

      before do
        @user = create(:user)
        @post = create(:post)
        visit signin_path
        fill_in "username", with: @user.username
        fill_in "password", with: @user.password
        click_button "Sign in"
        # TODO: create helper method for signing in a user
        click_link @post.title
      end

      specify "post title should be editable" do
        page.should have_selector 'input', value: @post.title
      end

      specify "post content should be editable" do
        page.should have_selector 'textarea', value: @post.content
      end

      describe "editing a post" do

        context "with invalid attributes" do

          before do
            fill_in "post_title", with: ''
            fill_in "post_content", with: ''
            click_button "Update Post"
          end

          it "displays error messages" do
            page.should have_content "errors"
            page.should have_content "can't be blank"
          end
        end

        context "with valid attributes" do

          before do
            @new_post_title = "Great new post"
            @new_post_content = "Nulla vitae elit libero, a pharetra augue."
            fill_in "post_title", with: @new_post_title
            fill_in "post_content", with: @new_post_content
            click_button "Update Post"
          end

          subject { page }

          it { should have_content "Updated!" }
          it { should have_content @new_post_title }
          it { should have_content @new_post_content }

          it "updates the post's attributes" do
            @post.reload.title.should == @new_post_title
            @post.reload.content.should == @new_post_content
          end
          # TODO: test publishing a draft
        end
      end

      describe "deleting a post" do

        it "deletes the post" do
          expect { click_link "Delete" }.to change(Post, :count).by(-1)
        end

        describe "redirects to the admin page" do

          before { click_link "Delete" }

          subject { page }

          it { should have_content "destroyed!" }
          it { should_not have_content @post.title }
          it { should have_link "Home" }
          it { should have_link "New post" }
          it { should have_link "Sign out" }
          it { should have_content "Drafts" }
          it { should have_content "Published" }
        end
      end
    end
  end

  describe "preview post page" do

    before do
      @user = create(:user)
      @post = create(:post)
      # TODO: should be reusing the same user throughout this spec
      visit signin_path
      fill_in "username", with: @user.username
      fill_in "password", with: @user.password
      click_button "Sign in"
      click_link @post.title
      click_link "Preview post"
    end

    it "displays the show post page" do
      page.should have_content @post.title
      page.should have_content @post.content
    end

    it "displays a link for exiting preview mode" do
      page.should have_content "Exit preview mode"
    end

    describe "exiting preview mode" do

      before { click_link "Exit preview mode" }

      it "returns the user to the edit post page" do
        page.should have_selector 'input', value: @post.title
        page.should have_selector 'textarea', value: @post.content
      end
    end
  end

  describe "show post page" do

    before do
      @post = create(:published_post)
      visit posts_path
      click_link @post.title
    end

    it "displays the post title" do
      page.should have_content @post.title
    end

    it "displays the post content" do
      page.should have_content @post.content
    end

    # TODO: test comments display
    # TODO: test social sharing
  end

  describe "archive page" do

    before do
      @post = create(:published_post)
      visit archive_path
    end

    subject { page }

    describe "shows the month name when posts were created" do
      it { should have_link "#{@post.published_at.strftime('%B')}" }
    end
  end

  describe "about page" do

    before { visit about_path }

    subject { page }

    it { should have_content "Scott Epple" }
    it { should have_content "whoami" }
  end

  describe "RSS" do
    # TODO: test RSS
  end
end
