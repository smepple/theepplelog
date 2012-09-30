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
  attr_accessible :title, :slug, :content, :draft, :published_at

  before_create :set_slug
  before_save :set_published_at

  def set_slug
    self.slug = self.title.parameterize
  end

  def set_published_at
    self.published_at = Time.now.utc unless self.draft?
  end
end
