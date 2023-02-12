class CreateGlobalSettings < ActiveRecord::Migration[7.0]
  def change
    create_table :global_settings, id: :uuid do |t|
      t.string :name
      t.string :code, index: { unique: true }
      t.text :value

      t.timestamps
    end
  end
end
