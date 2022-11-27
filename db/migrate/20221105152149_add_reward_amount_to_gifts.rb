class AddRewardAmountToGifts < ActiveRecord::Migration[7.0]
  def change
    remove_column :gifts, :amount, :integer
    add_column :gifts, :reward_amount, :integer, array: true, default: [0, 0, 0, 0]
  end
end
