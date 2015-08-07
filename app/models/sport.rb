class Sport < ActiveRecord::Base
  belongs_to :user
  has_many :events

  def owned_by?(user)
    user_id == user.id
  end
end