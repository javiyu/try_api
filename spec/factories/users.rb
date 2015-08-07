FactoryGirl.define do
  factory :admin, class: 'User' do
    name 'admin'
    password 'admin'
    role factory: :admin_role
  end

  factory :user, class: 'User' do
    name 'user'
    password 'user'
    role factory: :user_role
  end

  factory :guest, class: 'User' do
    name 'guest'
    password 'guest'
    role factory: :guest_role
  end
end