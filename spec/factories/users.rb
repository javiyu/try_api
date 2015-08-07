FactoryGirl.define do
  factory :admin, class: 'User' do
    name 'admin'
    password 'admin'
    role factory: :admin_role
  end
end