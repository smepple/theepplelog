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