require 'simple_json_api'

# TagSerializer for testing
class TagSerializer < SimpleJsonApi::ResourceSerializer
  serializes :tags, primary_key: :guid, model: Tag
  attribute :guid
  attribute :name

  has_many :taggables, polymorphic: true
end

# TaggingSerializer for testing
class TaggingSerializer < SimpleJsonApi::ResourceSerializer
  serializes :taggings
  attribute :id
  belongs_to :tag
  belongs_to :taggable, polymorphic: true
end

# TodoSerializer for testing
class TodoSerializer < SimpleJsonApi::ResourceSerializer
  serializes :todos, model: Todo
  attribute :id
  attribute :action
  attribute :location
  attribute :notes
  has_many :tags
  def href
    "http://example.com/todos/#{_object.id}"
  end
end

# TodolistSerializer for testing
class TodolistSerializer < SimpleJsonApi::ResourceSerializer
  serializes :todolists, model: Todolist
  attribute :id
  attribute :description
  has_many :todos
  has_many :tags
  def href
    "http://example.com/todolists/#{_object.id}"
  end
end

# ProjectSerializer for testing
class ProjectSerializer < SimpleJsonApi::ResourceSerializer
  serializes :projects, model: Project
  attribute :id
  attribute :name, key: :project_name
  attribute :description
  attribute :position
  has_one :todolist
  has_many :tags
  def href
    "http://example.com/projects/#{_object.id}"
  end
end
