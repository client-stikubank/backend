class AddRewardAmountToCamps < ActiveRecord::Migration[7.0]
  def change
    add_column :camps, :reward_amount, :integer, array: true, default: [0, 0, 0 ,0]
  end
end
