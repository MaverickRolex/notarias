# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180423022650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "candidacies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "candidates", force: :cascade do |t|
    t.string   "name"
    t.integer  "political_party_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "evidences", force: :cascade do |t|
    t.string   "file"
    t.integer  "user_id"
    t.integer  "segment_message_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["segment_message_id"], name: "index_evidences_on_segment_message_id", using: :btree
    t.index ["user_id"], name: "index_evidences_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "featurette_object"
    t.string   "featurette_type"
    t.integer  "featurette_id"
    t.boolean  "permitted",         default: true
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.integer  "authorizable_id"
    t.string   "authorizable_type"
    t.string   "action",            default: "manage"
    t.index ["featurette_id", "featurette_type", "authorizable_id", "authorizable_type", "action"], name: "index_permissions_on_ftrt_object_and_authorizable_and_action", unique: true, using: :btree
    t.index ["featurette_object", "authorizable_id", "authorizable_type", "action"], name: "index_permissions_on_featurette_and_authorizable_and_action", unique: true, using: :btree
  end

  create_table "political_candidacies", force: :cascade do |t|
    t.integer  "candidacy_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "candidate_id"
    t.integer  "segment_id"
    t.index ["segment_id", "candidacy_id", "candidate_id"], name: "political_candidacies_by_assignations", unique: true, using: :btree
  end

  create_table "political_parties", force: :cascade do |t|
    t.string   "name"
    t.boolean  "coalition"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.text     "parties_ids", default: [],              array: true
  end

  create_table "preferences", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.text     "default_values"
    t.boolean  "encrypted"
    t.integer  "field_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "prep_processes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "segment_id"
    t.integer  "current_step"
    t.datetime "completed_at"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "prep_step_fives", force: :cascade do |t|
    t.integer  "prep_process_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["prep_process_id"], name: "index_prep_step_fives_on_prep_process_id", using: :btree
  end

  create_table "prep_step_fours", force: :cascade do |t|
    t.integer  "prep_process_id"
    t.text     "data",            default: "{}"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "prep_step_ones", force: :cascade do |t|
    t.integer  "prep_process_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "prep_step_threes", force: :cascade do |t|
    t.integer  "prep_process_id"
    t.integer  "voters_count",    default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "prep_step_twos", force: :cascade do |t|
    t.integer  "prep_process_id"
    t.integer  "males",           default: 0
    t.integer  "females",         default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["females"], name: "index_prep_step_twos_on_females", using: :btree
    t.index ["males"], name: "index_prep_step_twos_on_males", using: :btree
  end

  create_table "procedures", force: :cascade do |t|
    t.string   "name"
    t.integer  "creator_user_id"
    t.float    "version"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "priority"
  end

  create_table "segment_candidacies", force: :cascade do |t|
    t.integer  "segment_id"
    t.integer  "candidacy_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["candidacy_id"], name: "index_segment_candidacies_on_candidacy_id", using: :btree
    t.index ["segment_id", "candidacy_id"], name: "index_segment_candidacies_on_segment_id_and_candidacy_id", unique: true, using: :btree
    t.index ["segment_id"], name: "index_segment_candidacies_on_segment_id", using: :btree
  end

  create_table "segment_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
    t.index ["ancestor_id", "descendant_id", "generations"], name: "segment_anc_desc_idx", unique: true, using: :btree
    t.index ["descendant_id"], name: "segment_desc_idx", using: :btree
  end

  create_table "segment_messages", force: :cascade do |t|
    t.integer  "segment_id"
    t.integer  "segment_message_id"
    t.integer  "user_id"
    t.text     "message"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["segment_id"], name: "index_segment_messages_on_segment_id", using: :btree
    t.index ["segment_message_id"], name: "index_segment_messages_on_segment_message_id", using: :btree
    t.index ["user_id"], name: "index_segment_messages_on_user_id", using: :btree
  end

  create_table "segment_user_imports", force: :cascade do |t|
    t.integer  "segment_id"
    t.integer  "uploader_id"
    t.string   "file"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "status",      default: "incomplete"
  end

  create_table "segments", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "task_hierarchies", force: :cascade do |t|
    t.integer  "required_task_id"
    t.integer  "requirer_task_id"
    t.integer  "procedure_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "task_orders", force: :cascade do |t|
    t.integer  "procedure_id"
    t.integer  "task_id"
    t.integer  "order"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_groups", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "group_id"], name: "index_user_groups_on_user_id_and_group_id", unique: true, using: :btree
  end

  create_table "user_preferences", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "preference_id"
    t.text     "value",         default: ""
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_segments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "segment_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.boolean  "representative"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "father_last_name"
    t.string   "mother_last_name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "locked_at"
    t.string   "username"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

end
