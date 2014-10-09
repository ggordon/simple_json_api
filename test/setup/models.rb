# Project for testing
class Project < ActiveRecord::Base
  has_one :todolist
  has_many :taggings, as: :taggable, class_name: 'Tagging'
  has_many :tags, through: :taggings, source: :tag, class_name: 'Tag'
end

# Todolist for testing
class Todolist < ActiveRecord::Base
  belongs_to :project
  has_many :todos
  has_many :taggings, as: :taggable, class_name: 'Tagging'
  has_many :tags, through: :taggings, source: :tag, class_name: 'Tag'
end

# To_do: misspelled so it won't be mistaken for the similarly named thing
class Todo < ActiveRecord::Base
  belongs_to :todolist
  has_many :taggings, as: :taggable, class_name: 'Tagging'
  has_many :tags, through: :taggings, source: :tag, class_name: 'Tag'
end

# Tagging for testing
class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end

# Tag for testing
class Tag < ActiveRecord::Base
  self.primary_key = 'guid'
  has_many :taggings
  has_many :projects,
           through: :taggings,
           source: :taggable,
           source_type: 'Project'
  has_many :todolists,
           through: :taggings,
           source: :taggable,
           source_type: 'Todolist'
  has_many :todos,
           through: :taggings,
           source: :taggable,
           source_type: 'Todo'

  def taggables
    projects + todolists + todos
  end
end
