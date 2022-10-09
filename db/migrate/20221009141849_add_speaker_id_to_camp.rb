class AddSpeakerIdToCamp < ActiveRecord::Migration[7.0]
  def change
    add_reference :camps, :speaker, foreign_key: { to_table: :users }, type: :uuid, index: true
  end
end
