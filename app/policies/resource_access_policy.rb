class ResourceAccessPolicy
  attr_accessor :resource, :user

  CAN_READ_ALL = 'can_read_all_resources'
  CAN_READ_OWN = 'can_read_own_resources'
  CAN_CREATE = 'can_create_resources'
  CAN_UPDATE_ALL = 'can_update_all_resources'
  CAN_UPDATE_OWN = 'can_update_own_resources'
  CAN_DELETE_ALL = 'can_delete_all_resources'
  CAN_DELETE_OWN = 'can_delete_own_resources'


  def initialize(resource:, user:)
    self.resource = resource
    self.user = user
  end

  def can_read?
    has_permission?(CAN_READ_ALL) ||
      (resource_owned_by_user? && has_permission?(CAN_READ_OWN))
  end

  def can_create?
    has_permission?(CAN_CREATE)
  end

  def can_update?
    has_permission?(CAN_UPDATE_ALL) ||
      (resource_owned_by_user? && has_permission?(CAN_UPDATE_OWN))
  end

  def can_delete?
    has_permission?(CAN_DELETE_ALL) ||
      (resource_owned_by_user? && has_permission?(CAN_DELETE_OWN))
  end


  private
  def has_permission?(permission)
    user_permissions.include?(permission)
  end

  def user_permissions
    @user_permissions ||= user.permissions.pluck(:name)
  end

  def resource_owned_by_user?
    resource && resource.owned_by?(user)
  end
end
