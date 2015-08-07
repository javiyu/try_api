class Sport < ActiveRecord::Base
  belongs_to :user

  def owned_by?(user)
    user_id == user.id
  end
end