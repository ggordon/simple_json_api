require 'simple_json_api/association'
require 'simple_json_api/attribute'
require 'simple_json_api/refinements/array'

# SimpleJsonApi
module SimpleJsonApi
  # Define the public API for creating serializers
  module DSL
    using Refinements::Array

    attr_accessor :_associations
    attr_accessor :_attributes
    attr_accessor :_default_fields
    attr_accessor :_required_associations
    attr_reader :_root_name

    def inherited(base)
      base._associations = []
      base._attributes = []
    end

    def serializes(name, options = {})
      Serializer.register_serializer(
        { serializer: self, resource: name },
        options
      )
      @_root_name = name
    end

    def attribute(name, options = {})
      register_attribute(name, options)
    end

    # Attributes presented if no fields specified
    def default_fields(attrs)
      @_default_fields = attrs
    end

    # Associations that are always included
    def required_associations(assocs)
      @_required_associations = assocs
    end

    def belongs_to(name, options = {})
      register_association(name, :belongs_to, options)
    end

    def has_many(name, options = {})
      register_association(name, :has_many, options)
    end

    def has_one(name, options = {})
      register_association(name, :has_one, options)
    end

    def default_attributes
      @_attributes.map(&:first).join(',')
    end

    private

    def register_association(name, type, options)
      serializer = options.fetch(:serializer, nil)
      polymorphic = options.fetch(:polymorphic, false)
      association = Association.new(
        name, type, serializer, polymorphic
      )
      _associations << association
      define_assoc_method(association) # unless defined? association.name
    end

    def define_assoc_method(association)
      if association.type == :has_many
        define_method association.name do |includes = nil|
          _object.send(association.name).includes(includes).to_a if _object.respond_to?(association.name)
        end
      else
        define_method association.name do |includes = nil|
          _object.send(association.name) if _object.respond_to?(association.name)
        end
      end
    end

    def register_attribute(name, options)
      key = options.fetch(:key, nil)
      attribute = Attribute.new(name, key)
      _attributes << attribute
      def_delegator :_object, attribute.name
    end
  end
end
