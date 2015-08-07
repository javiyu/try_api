FactoryGirl.define do
  factory :can_read_all, class: 'Permission' do
    name ResourceAccessPolicy::CAN_READ_ALL
  end

  factory :can_read_own, class: 'Permission' do
    name ResourceAccessPolicy::CAN_READ_OWN
  end

  factory :can_create, class: 'Permission' do
    name ResourceAccessPolicy::CAN_CREATE
  end

  factory :can_update_all, class: 'Permission' do
    name ResourceAccessPolicy::CAN_UPDATE_ALL
  end

  factory :can_update_own, class: 'Permission' do
    name ResourceAccessPolicy::CAN_UPDATE_OWN
  end

  factory :can_delete_all, class: 'Permission' do
    name ResourceAccessPolicy::CAN_DELETE_ALL
  end

  factory :can_delete_own, class: 'Permission' do
    name ResourceAccessPolicy::CAN_DELETE_OWN
  end
end