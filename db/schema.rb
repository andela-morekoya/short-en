ActiveRecord::Schema.define(version: 20_161_003_090_303) do
  create_table 'links', force: :cascade do |t|
    t.string   'original'
    t.string   'slug'
    t.boolean  'active', default: true
    t.datetime 'created_at',                null: false
    t.datetime 'updated_at',                null: false
    t.integer  'user_id', default: 0, null: false
    t.string   'title'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username',        null: false
    t.string 'email',           null: false
    t.string 'password_digest'
  end

  create_table 'visits', force: :cascade do |t|
    t.integer  'link_id'
    t.integer  'user_id'
    t.string   'ip_address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  add_index 'visits', ['link_id'], name: 'index_visits_on_link_id'
  add_index 'visits', ['user_id'], name: 'index_visits_on_user_id'
end
