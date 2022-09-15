# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Web Admin Client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'Apps Client', redirect_uri: '', scopes: '')
end

# generate roles
roles = %w[admin operator student teacher guardian]

roles.each do |role|
  Role.find_or_create_by(name: role)
end

# genereate permissions
actions = %w[read create update destroy]

object_without_create_list = %w[Stage Coin]
object_without_update_list = %w[Carnival Refferal]
object_without_destroy_list = %w[Role Refferal]
objects = %w[User Role Carnival Camp Stage StageCamp StageCampSchedule Coin Province City]
actions.each do |action|
  objects.each do |object|
    next if object_without_create_list.include?(object) && action.eql?('create')

    next if object_without_update_list.include?(object) && action.eql?('update')

    next if object_without_destroy_list.include?(object) && action.eql?('destroy')

    Permission.find_or_create_by(object_type: object, action_name: action)
  end
end

# default_operator_permissions
operator_id = Role.find_by_name('operator').id
permissions = Permission.all

permissions.each do |permission|
  RolePermission.find_or_create_by(role_id: operator_id, permission_id: permission.id)
end

# generate default users
default_admin = User.create(
  email: 'admin_client01@mailinator.com',
  password: 'Admin123!'
)

default_admin.update(role_ids: Role.find_by_name('admin').id)
default_admin.build_user_profile(first_name: 'Super', last_name: 'Admin', birth_date: '1995-01-01', phone_number: '08888888').save

default_student = User.create(
  email: 'user_client01@mailinator.com',
  password: 'Admin123!'
)

default_student.update(role_ids: Role.find_by_name('student').id)
default_student.build_user_profile(first_name: 'First', last_name: 'Student', birth_date: '1995-01-01', phone_number: '088888881').save

# generate default carnival
carnival = Carnival.find_or_initialize_by(name: 'First Carnival')
carnival.finished_at = carnival.finished_at || Time.zone.now + 6.month
carnival.save!
carnival.assessments.create! unless carnival.assessments.exists?

Coin.names.to_a.each do |name|
  coin = Coin.find_or_initialize_by(name: name[0])
  coin.save!
end
