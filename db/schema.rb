# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_09_020735) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "assessment_answers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "assessment_id"
    t.uuid "assessment_question_id"
    t.uuid "user_id"
    t.integer "answer"
    t.integer "index_order"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assessment_id"], name: "index_assessment_answers_on_assessment_id"
    t.index ["assessment_question_id"], name: "index_assessment_answers_on_assessment_question_id"
    t.index ["user_id"], name: "index_assessment_answers_on_user_id"
  end

  create_table "assessment_questions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "question"
    t.string "choice_1_text"
    t.string "choice_2_text"
    t.string "choice_1_image"
    t.string "choice_2_image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "choice_1_type"
    t.string "choice_2_type"
    t.integer "status", default: 0
  end

  create_table "assessments", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "status", default: 0, null: false
    t.string "programmable_type"
    t.uuid "programmable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "user_id"
    t.datetime "completed_at"
    t.jsonb "results"
    t.uuid "personality_id"
    t.index ["personality_id"], name: "index_assessments_on_personality_id"
    t.index ["programmable_type", "programmable_id"], name: "index_assessments_on_programmable"
    t.index ["user_id"], name: "index_assessments_on_user_id"
  end

  create_table "camps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.integer "level", default: 1, null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "speaker_id"
    t.integer "reward_amount", default: [0, 0, 0, 0], array: true
    t.string "subtitle"
    t.index ["speaker_id"], name: "index_camps_on_speaker_id"
  end

  create_table "carnival_gifts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "gift_id"
    t.uuid "carnival_id"
    t.integer "quantity", default: 0
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carnival_id"], name: "index_carnival_gifts_on_carnival_id"
    t.index ["gift_id"], name: "index_carnival_gifts_on_gift_id"
  end

  create_table "carnivals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.date "finished_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
  end

  create_table "cities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.uuid "province_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_cities_on_deleted_at"
    t.index ["province_id"], name: "index_cities_on_province_id"
  end

  create_table "coins", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.integer "name", null: false
    t.text "description"
    t.bigint "max_supply", default: 0, null: false
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "device_infos", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "token"
    t.string "device_type"
    t.uuid "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_device_infos_on_user_id"
  end

  create_table "events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "city_id"
    t.string "title"
    t.string "image"
    t.text "description"
    t.integer "reward_amount", default: [0, 0, 0, 0], array: true
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "address"
    t.string "map_link"
    t.integer "status", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "duration"
    t.datetime "event_at"
    t.index ["city_id"], name: "index_events_on_city_id"
    t.index ["deleted_at"], name: "index_events_on_deleted_at"
    t.index ["title", "deleted_at"], name: "index_events_on_title_and_deleted_at", unique: true
  end

  create_table "gifts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.text "description"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reward_amount", default: [0, 0, 0, 0], array: true
    t.index ["deleted_at"], name: "index_gifts_on_deleted_at"
    t.index ["name", "deleted_at"], name: "index_gifts_on_name_and_deleted_at", unique: true
  end

  create_table "global_settings", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "code"
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_global_settings_on_code", unique: true
  end

  create_table "oauth_access_tokens", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "resource_owner_type"
    t.uuid "resource_owner_id"
    t.uuid "application_id", null: false
    t.string "token", null: false
    t.string "refresh_token"
    t.integer "expires_in"
    t.datetime "revoked_at"
    t.datetime "created_at", null: false
    t.string "scopes"
    t.string "previous_refresh_token", default: "", null: false
    t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
    t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
    t.index ["resource_owner_type", "resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner"
    t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
  end

  create_table "oauth_applications", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.string "secret", null: false
    t.text "redirect_uri"
    t.string "scopes", default: "", null: false
    t.boolean "confidential", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
  end

  create_table "parent_informations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_profile_id"
    t.integer "graduate_status"
    t.string "occupation"
    t.integer "salary_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_profile_id"], name: "index_parent_informations_on_user_profile_id"
  end

  create_table "permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "object_type"
    t.string "action_name"
    t.text "description"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "personalities", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.string "image"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_personalities_on_name", unique: true
  end

  create_table "provinces", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_provinces_on_deleted_at"
  end

  create_table "qr_clues", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.text "clue"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "questionnaires", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "question"
    t.text "answers", default: [], array: true
    t.integer "reward_amount", default: [0, 0, 0, 0], array: true
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "status", default: 0, null: false
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deleted_at"], name: "index_questionnaires_on_deleted_at"
    t.index ["question", "deleted_at"], name: "index_questionnaires_on_question_and_deleted_at", unique: true
  end

  create_table "redeems", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "amount", default: 0, null: false
    t.uuid "from_id"
    t.uuid "to_id"
    t.string "kindable_type"
    t.uuid "kindable_id"
    t.uuid "coin_id"
    t.integer "redeem_type", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_redeems_on_coin_id"
    t.index ["from_id"], name: "index_redeems_on_from_id"
    t.index ["kindable_type", "kindable_id"], name: "index_redeems_on_kindable"
    t.index ["to_id"], name: "index_redeems_on_to_id"
  end

  create_table "refferals", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "reffered_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reffered_by_id"], name: "index_refferals_on_reffered_by_id"
    t.index ["user_id"], name: "index_refferals_on_user_id"
  end

  create_table "rewards", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "amount", default: 0, null: false
    t.uuid "from_id"
    t.uuid "to_id"
    t.string "activitable_type"
    t.uuid "activitable_id"
    t.uuid "coin_id"
    t.integer "reward_type", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activitable_type", "activitable_id"], name: "index_rewards_on_activitable"
    t.index ["coin_id"], name: "index_rewards_on_coin_id"
    t.index ["from_id"], name: "index_rewards_on_from_id"
    t.index ["to_id"], name: "index_rewards_on_to_id"
  end

  create_table "role_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "role_id"
    t.uuid "permission_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["permission_id"], name: "index_role_permissions_on_permission_id"
    t.index ["role_id"], name: "index_role_permissions_on_role_id"
  end

  create_table "roles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "stage_camp_schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "stage_camp_id"
    t.date "started_at", null: false
    t.string "time_start", null: false
    t.string "time_end", null: false
    t.integer "quota", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.string "link"
    t.integer "learning_type", default: 0
    t.index ["stage_camp_id"], name: "index_stage_camp_schedules_on_stage_camp_id"
  end

  create_table "stage_camps", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "stage_id"
    t.uuid "camp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_stage_camps_on_camp_id"
    t.index ["stage_id"], name: "index_stage_camps_on_stage_id"
  end

  create_table "stages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.uuid "carnival_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "level"
    t.index ["carnival_id"], name: "index_stages_on_carnival_id"
  end

  create_table "stocks", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "coin_id"
    t.bigint "balance", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_stocks_on_coin_id"
  end

  create_table "student_informations", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_profile_id"
    t.integer "education_status"
    t.string "previous_school"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_profile_id"], name: "index_student_informations_on_user_profile_id"
  end

  create_table "transactions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "sourceable_type"
    t.uuid "sourceable_id"
    t.string "transactable_type"
    t.uuid "transactable_id"
    t.integer "subject", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sourceable_id", "transactable_id", "subject"], name: "dup_transaction_index", unique: true
    t.index ["sourceable_type", "sourceable_id"], name: "index_transactions_on_sourceable"
    t.index ["transactable_type", "transactable_id"], name: "index_transactions_on_transactable"
  end

  create_table "transfers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.bigint "amount", default: 0, null: false
    t.uuid "from_id"
    t.uuid "to_id"
    t.uuid "coin_id"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_transfers_on_coin_id"
    t.index ["from_id"], name: "index_transfers_on_from_id"
    t.index ["to_id"], name: "index_transfers_on_to_id"
  end

  create_table "user_carnival_gifts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "carnival_gift_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carnival_gift_id"], name: "index_user_carnival_gifts_on_carnival_gift_id"
    t.index ["user_id"], name: "index_user_carnival_gifts_on_user_id"
  end

  create_table "user_events", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "event_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_user_events_on_event_id"
    t.index ["user_id"], name: "index_user_events_on_user_id"
  end

  create_table "user_profiles", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.date "birth_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "city_id"
    t.string "image"
    t.index ["city_id"], name: "index_user_profiles_on_city_id"
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "user_questionnaires", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "questionnaire_id"
    t.string "answer"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["questionnaire_id"], name: "index_user_questionnaires_on_questionnaire_id"
    t.index ["user_id"], name: "index_user_questionnaires_on_user_id"
  end

  create_table "user_stage_schedules", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "stage_camp_schedule_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0, null: false
    t.index ["stage_camp_schedule_id"], name: "index_user_stage_schedules_on_stage_camp_schedule_id"
    t.index ["user_id"], name: "index_user_stage_schedules_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "refferal_code"
    t.string "reset_code"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  create_table "wallets", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "user_id"
    t.uuid "coin_id"
    t.bigint "balance", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coin_id"], name: "index_wallets_on_coin_id"
    t.index ["user_id", "coin_id"], name: "index_wallets_on_user_id_and_coin_id", unique: true
    t.index ["user_id"], name: "index_wallets_on_user_id"
  end

  add_foreign_key "assessment_answers", "assessment_questions"
  add_foreign_key "assessment_answers", "assessments"
  add_foreign_key "assessment_answers", "users"
  add_foreign_key "assessments", "personalities"
  add_foreign_key "assessments", "users"
  add_foreign_key "camps", "users", column: "speaker_id"
  add_foreign_key "carnival_gifts", "carnivals"
  add_foreign_key "carnival_gifts", "gifts"
  add_foreign_key "cities", "provinces"
  add_foreign_key "device_infos", "users"
  add_foreign_key "events", "cities"
  add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
  add_foreign_key "parent_informations", "user_profiles"
  add_foreign_key "redeems", "coins"
  add_foreign_key "redeems", "stocks", column: "to_id"
  add_foreign_key "redeems", "wallets", column: "from_id"
  add_foreign_key "refferals", "users"
  add_foreign_key "refferals", "users", column: "reffered_by_id"
  add_foreign_key "rewards", "coins"
  add_foreign_key "rewards", "stocks", column: "from_id"
  add_foreign_key "rewards", "wallets", column: "to_id"
  add_foreign_key "role_permissions", "permissions"
  add_foreign_key "role_permissions", "roles"
  add_foreign_key "stage_camp_schedules", "stage_camps"
  add_foreign_key "stage_camps", "camps"
  add_foreign_key "stage_camps", "stages"
  add_foreign_key "stages", "carnivals"
  add_foreign_key "stocks", "coins"
  add_foreign_key "student_informations", "user_profiles"
  add_foreign_key "transfers", "coins"
  add_foreign_key "transfers", "wallets", column: "from_id"
  add_foreign_key "transfers", "wallets", column: "to_id"
  add_foreign_key "user_carnival_gifts", "carnival_gifts"
  add_foreign_key "user_carnival_gifts", "users"
  add_foreign_key "user_events", "events"
  add_foreign_key "user_events", "users"
  add_foreign_key "user_profiles", "cities"
  add_foreign_key "user_profiles", "users"
  add_foreign_key "user_questionnaires", "questionnaires"
  add_foreign_key "user_questionnaires", "users"
  add_foreign_key "user_stage_schedules", "stage_camp_schedules"
  add_foreign_key "user_stage_schedules", "users"
  add_foreign_key "users_roles", "roles"
  add_foreign_key "users_roles", "users"
  add_foreign_key "wallets", "coins"
  add_foreign_key "wallets", "users"
end
