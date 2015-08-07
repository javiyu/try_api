
admin_role = Role.create!(name: 'admin')
user_role = Role.create!(name: 'user')
guest_role = Role.create!(name: 'guest')

User.create!(name: 'admin', password: 'admin', role: admin_role)
User.create!(name: 'user', password: 'user', role: user_role)
User.create!(name: 'guest', password: 'guest', role: guest_role)

can_create_resources_permission = Permission.create!(name: 'can_create_resources')

can_read_own_resources_permission = Permission.create!(name: 'can_read_own_resources')
can_update_own_resources_permission = Permission.create!(name: 'can_update_own_resources')
can_delete_own_resources_permission = Permission.create!(name: 'can_delete_own_resources')

can_read_all_resources_permission = Permission.create!(name: 'can_read_all_resources')
can_update_all_resources_permission = Permission.create!(name: 'can_update_all_resources')
can_delete_all_resources_permission = Permission.create!(name: 'can_delete_all_resources')


admin_role.permissions = [can_read_all_resources_permission, can_create_resources_permission,
  can_update_all_resources_permission, can_delete_all_resources_permission]

user_role.permissions = [can_read_all_resources_permission, can_create_resources_permission,
  can_update_own_resources_permission, can_delete_own_resources_permission]

guest_role.permissions = [can_read_all_resources_permission]
