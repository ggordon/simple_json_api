ActiveRecord::Schema.define do
  self.verbose = false

  create_table :projects do |t|
    t.string :name
    t.string :description
    t.integer :position
    t.timestamps
  end

  create_table :todolists do |t|
    t.string :name
    t.string :description
    t.references :project
    t.timestamps
  end

  create_table :todos do |t|
    t.string :action
    t.string :location
    t.text :notes
    t.integer :duration_in_secs
    t.integer :priority
    t.references :todolist
    t.timestamps
  end

  create_table :tags, id: false do |t|
    t.primary_key :guid
    t.string :name
  end

  create_table :taggings do |t|
    t.references :tag
    t.references :taggable, polymorphic: true
    t.datetime :created_at
  end
end
