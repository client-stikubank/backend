class AddDescriptionToCarnival < ActiveRecord::Migration[7.0]
  def change
    add_column :carnivals, :description, :text
  end
end
