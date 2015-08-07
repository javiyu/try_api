class Event < ActiveRecord::Base
  belongs_to :sport
  belongs_to :user

  def owned_by?(user)
    user_id == user.id
  end
end