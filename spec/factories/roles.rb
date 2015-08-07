FactoryGirl.define do
  factory :admin_role, class: 'Role' do
    name 'admin'
    permissions do
      [FactoryGirl.create(:can_read_all), FactoryGirl.create(:can_create),
        FactoryGirl.create(:can_update_all), FactoryGirl.create(:can_delete_all)]
    end
  end

  factory :user_role, class: 'Role' do
    name 'user'
    permissions do
      [FactoryGirl.create(:can_read_all), FactoryGirl.create(:can_create),
        FactoryGirl.create(:can_update_own), FactoryGirl.create(:can_delete_own)]
    end
  end

  factory :guest_role, class: 'Role' do
    name 'guest'
    permissions do
      [FactoryGirl.create(:can_read_all)]
    end
  end
end