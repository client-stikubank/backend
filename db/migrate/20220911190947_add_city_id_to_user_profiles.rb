class AddCityIdToUserProfiles < ActiveRecord::Migration[7.0]
  def change
    add_reference :user_profiles, :city, foreign_key: true, type: :uuid, index: true
  end
end
