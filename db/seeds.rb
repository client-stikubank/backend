# frozen_string_literal: true

if Doorkeeper::Application.count.zero?
  Doorkeeper::Application.create!(name: 'Web Admin Client', redirect_uri: '', scopes: '')
  Doorkeeper::Application.create!(name: 'Apps Client', redirect_uri: '', scopes: '')
end

User.create(
  email: 'admin_client01@mailinator.com',
  password: 'Admin123!',
  role: User.roles[:admin]
)

User.create(
  email: 'user_client01@mailinator.com',
  password: 'Admin123!',
  role: User.roles[:user]
)

carnival = Carnival.find_or_create_by!(
  name: 'First Carnival',
  finished_at: Time.zone.now + 2.months
)

carnival.assessments.create!

Coin.names.to_a.each do |name|
  coin = Coin.find_or_initialize_by(name: name[0])
  coin.max_supply ||= 10_000
  coin.save!
end
