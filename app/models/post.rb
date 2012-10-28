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

class Post < ActiveRecord::Base
  attr_accessible :title, :slug, :content, :draft, :published_at, :tag_list
  acts_as_taggable

  # support for versioning
  has_paper_trail

  validates_presence_of :title, :slug, :content
  validates_uniqueness_of :title, :slug, :on => :create
  validates_length_of :title, :in => 2..50

  default_scope :order => 'published_at DESC'

  before_validation :set_slug
  before_save :set_published_at

  def set_slug
    self.slug = self.title.parameterize
  end

  def set_published_at
    if !self.draft? && self.published_at.nil?
      self.published_at = Time.now.utc
    end
  end
end
