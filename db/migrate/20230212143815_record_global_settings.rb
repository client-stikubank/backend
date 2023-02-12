class RecordGlobalSettings < ActiveRecord::Migration[7.0]
  def change
    GlobalSetting.create!(name: 'Invite Message', var: 'invite_message', value: 'Hai Youthcampers!\n')
  end
end
