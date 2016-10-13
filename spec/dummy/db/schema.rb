ActiveRecord::Schema.define(version: 20161013025452) do
  create_table :projects do |t|
    t.string :name            , null: false
  end

  create_table :issues do |t|
    t.references :project, null: false, foreign_key: true
    t.string :title, null: false
    t.integer :status, null: false
  end
end
