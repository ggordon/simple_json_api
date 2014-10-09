ActiveRecord::Schema.define do
  self.verbose = false

  create_table :projects do |t|
    t.string :name
    t.timestamps
  end

  create_table :todolists do |t|
    t.string :description
    t.references :project
    t.timestamps
  end

  create_table :todos do |t|
    t.string :action
    t.references :todolist
    t.timestamps
  end

  create_table :tags do |t|
    t.string :name
  end

  create_table :taggings do |t|
    t.references :tag
    t.references :taggable, polymorphic: true
    t.datetime :created_at
  end
end
