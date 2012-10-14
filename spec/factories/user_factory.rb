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

FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "testuser#{n}" }
    email { "#{username}@example.com" }
    password "foobarbaz"
  end
end
