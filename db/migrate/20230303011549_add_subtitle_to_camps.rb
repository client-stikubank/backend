class AddSubtitleToCamps < ActiveRecord::Migration[7.0]
  def change
    add_column :camps, :subtitle, :string
  end
end
