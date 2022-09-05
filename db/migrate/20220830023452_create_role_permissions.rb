# frozen_string_literal: true

class CreateRolePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :role_permissions, id: :uuid do |t|
      t.references :role, foreign_key: true, type: :uuid, index: true
      t.references :permission, foreign_key: true, type: :uuid, index: true
      t.timestamps
    end
  end
end
