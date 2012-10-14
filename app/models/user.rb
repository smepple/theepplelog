# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password

  attr_accessible :username

  validates_presence_of :username, :password
  validates_length_of :username, in: 4..12
  validates_length_of :password, minimum: 8
end
