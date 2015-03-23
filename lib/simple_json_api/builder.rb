require 'simple_json_api/api_node'
require 'simple_json_api/field_list'
require 'simple_json_api/include_list'
require 'simple_json_api/refinements/active_record'
require 'simple_json_api/serializer_factory'

# SimpleJsonApi
module SimpleJsonApi
  # The Builder to walk the hierarchy and construct the JSON
  class Builder
    extend Forwardable

    attr_reader :wrapper
    attr_reader :field_list
    attr_reader :include
    attr_reader :object
    attr_reader :serializer

    def_delegators :@field_list, :fields_for

    # TODO: sort: nil
    def initialize(object, wrapper, serializer, fields, include, page)
      @object = object
      @wrapper = wrapper
      @field_list = FieldList.new(fields, serializer)
      @include = IncludeList.new(include).parse
      @page = page
      @serializer = SerializerFactory.create(object, serializer, self)
    end

    def as_json(options = nil)
      root_node = ApiNode.new(serializer._root_name, serializer, include.include_hash).load
      wrapper.new(root_node, @page).as_json(options)
    end
  end
end
