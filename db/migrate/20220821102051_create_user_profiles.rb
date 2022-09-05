class CreateUserProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :user_profiles, id: :uuid do |t|
      t.references :user, foreign_key: true, type: :uuid, index: true
      t.string     :first_name
      t.string     :last_name
      t.string     :phone_number
      t.date       :birth_date
      t.timestamps
    end
  end
end
