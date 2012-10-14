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

FactoryGirl.define do
  factory :post do
    sequence(:title) { |n| "Lorem ipsum #{n}" }
    content "Etiam porta sem malesuada magna mollis euismod."
    draft true

    factory :published_post do
      draft false
    end
  end
end
