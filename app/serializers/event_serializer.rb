class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :user

  def user
    User.find(object.user_id).name
  end
end