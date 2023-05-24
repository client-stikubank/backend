class DeviceInfo < ActiveRecord::Migration[7.0]
  def change
    create_table :device_infos, id: :uuid do |t|
      t.string :token
      t.string :device_type
      t.references :user, foreign_key: true, type: :uuid, index: true

      t.timestamps
    end
  end
end
