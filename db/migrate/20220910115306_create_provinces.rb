class CreateProvinces < ActiveRecord::Migration[7.0]
  def change
    create_table :provinces, id: :uuid do |t|
      t.string   :name
      t.timestamps
    end
  end
end
