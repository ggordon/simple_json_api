require 'simple_json_api/version'

require 'simple_json_api/active_record_refinements'
require 'simple_json_api/array_refinements'
# require 'simple_json_api/association'
# require 'simple_json_api/attribute'
require 'simple_json_api/dsl'
require 'simple_json_api/field_list'
require 'simple_json_api/include_list'

require 'simple_json_api/serializer'
require 'simple_json_api/array_serializer'
require 'simple_json_api/resource_serializer'

require 'simple_json_api/json_api_builder'

require 'simple_json_api/helper'

# SimpleJsonApi
module SimpleJsonApi
  # Wrapper for a linked association
  Association = Struct.new(:name, :type, :serializer, :polymorphic, :key) do
    def key
      name_s = name.to_s
      (type == :has_many) ? name_s.pluralize.to_sym : name_s.singularize.to_sym
    end
  end

  # Attribute
  Attribute = Struct.new(:name, :key) do
    def key
      self[:key] || self[:name]
    end
  end

  # Main hook to generate json
  def self.render(model:, serializer:, options: {})
    JsonApiBuilder.new(model, serializer, options).to_json
  end
end
