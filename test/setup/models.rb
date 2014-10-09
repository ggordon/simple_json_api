class Project < ActiveRecord::Base
  has_one :todolist
  has_many :taggings, as: :taggable, class_name: 'Tagging'
  has_many :tags, through: :taggings, source: :tag, class_name: 'Tag'
end

class Todolist < ActiveRecord::Base
  belongs_to :project
  has_many :todos
  has_many :taggings, as: :taggable, class_name: 'Tagging'
  has_many :tags, through: :taggings, source: :tag, class_name: 'Tag'
end

class Todo < ActiveRecord::Base
  belongs_to :todolist
  has_many :taggings, as: :taggable, class_name: 'Tagging'
  has_many :tags, through: :taggings, source: :tag, class_name: 'Tag'
end

class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end

class Tag < ActiveRecord::Base
  has_many :taggings
end
