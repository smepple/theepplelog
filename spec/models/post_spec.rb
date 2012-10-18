# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :string(255)
#  slug         :string(255)
#  content      :text
#  draft        :boolean          default(TRUE)
#  published_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'spec_helper'

describe Post do
  
  let(:post) { create(:post) }
  let(:dup_post) { post.dup }

  subject { post }

  it { should be_valid }

  it { should respond_to :title }
  it { should respond_to :slug }
  it { should respond_to :content }
  it { should respond_to :draft }
  it { should respond_to :published_at }
  it { should respond_to :set_slug }
  it { should respond_to :set_published_at }

  specify "when title is not unique" do
    dup_post.should_not be_valid
  end

  describe "when title is empty" do
    before { post.title = '' }
    it { should_not be_valid }
  end

  describe "when content is empty" do
    before { post.content = '' }
    it { should_not be_valid }
  end
end
