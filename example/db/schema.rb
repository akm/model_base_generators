# coding: utf-8
ActiveRecord::Schema.define(version: 20161013025452) do
  create_table :users do |t|
    t.string   :email,                  default: "", null: false
    t.string   :encrypted_password,     default: "", null: false
    t.string   :reset_password_token
    t.datetime :reset_password_sent_at
    t.datetime :remember_created_at
    t.integer  :sign_in_count,          default: 0,  null: false
    t.datetime :current_sign_in_at
    t.datetime :last_sign_in_at
    t.string   :current_sign_in_ip
    t.string   :last_sign_in_ip
    t.datetime :created_at,                          null: false
    t.datetime :updated_at,                          null: false
    t.index :email, unique: true
  end

  create_table :projects do |t|
    t.references :owner, null: false
    t.string :name            , null: false
    t.boolean :closed, null: false, default: false
  end
  add_foreign_key :projects, :users, column: 'owner_id'

  create_table :project_assignments do |t|
    t.references :project, null: false, foreign_key: true
    t.references :user   , null: false, foreign_key: true
    t.datetime :started_at
    t.datetime :finished_at
    t.datetime :created_at, null: false
  end

  create_table :issues do |t|
    t.references :project, null: false, foreign_key: true
    t.string :title, null: false
    t.integer :status, null: false
    t.references :creator, null: false
    t.datetime :created_at,                          null: false
    t.datetime :updated_at,                          null: false
  end
  add_foreign_key :issues, :users, column: 'creator_id'
end
