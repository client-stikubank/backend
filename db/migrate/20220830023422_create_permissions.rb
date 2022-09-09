# frozen_string_literal: true

class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions, id: :uuid do |t|
      t.string :object_type
      t.string :action_name
      t.text   :description
      t.timestamps
    end
  end
end
