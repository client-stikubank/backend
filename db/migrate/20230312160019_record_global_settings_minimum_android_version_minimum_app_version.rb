class RecordGlobalSettingsMinimumAndroidVersionMinimumAppVersion < ActiveRecord::Migration[7.0]
  def change
    GlobalSetting.create!(name: 'Minimum App Version', code: 'minimum_app_version', value: '1.0.5')
  end
end
