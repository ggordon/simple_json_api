# SimpleJsonApi
module SimpleJsonApi
  # Define the public API for creating serializers
  module DSL
    attr_accessor :_associations
    attr_accessor :_attributes
    attr_reader :_root_name

    def inherited(base)
      base._associations = []
      base._attributes = []
    end

    def serializes(name, options = {})
      ResourceSerializer.register_serializer(
        { serializer: self, resource: name },
        options
      )
      @_root_name = name
    end

    def attribute(name, options = {})
      register_attribute(name, options)
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

    def default_fields
      @_attributes.map(&:first).join(',')
    end

    private

    def register_association(name, type, options)
      serializer = options.fetch(:serializer, nil)
      polymorphic = options.fetch(:polymorphic, false)
      association = SimpleJsonApi::Association.new(
        name, type, serializer, polymorphic
      )
      _associations << association
      def_delegator :_object, association.name
    end

    def register_attribute(name, options)
      key = options.fetch(:key, nil)
      attribute = SimpleJsonApi::Attribute.new(name, key)
      _attributes << attribute
      def_delegator :_object, attribute.name
    end
  end
end
