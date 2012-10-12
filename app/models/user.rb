class User < ActiveRecord::Base
  authenticates_with_sorcery!
  # attr_accessible :title, :body

  validates_presence_of :username, :email
end
