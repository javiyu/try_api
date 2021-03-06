class User < ActiveRecord::Base
  belongs_to :role
  has_many :permissions, through: :role

  has_many :sports
  has_many :events
end
