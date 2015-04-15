require 'simple_json_api/dsl'
# require 'simple_json_api/refinements/array'

# SimpleJsonApi
module SimpleJsonApi
  # The Serializer will serialize a model
  class Serializer
    extend Forwardable
    extend DSL

    attr_reader :_builder
    attr_reader :_each_serializer
    attr_reader :_object
    attr_reader :_context

    def initialize(object, builder, context, each_serializer = nil, base = nil)
      @_object = object
      @_builder = builder
      @_context = context
      @_each_serializer = each_serializer
      @_base = base
    end

    def associated_object(association_name)
      send(association_name)
    end

    private

    def default_fields
      self.class._default_fields
    end

    def all_fields
      self.class.default_attributes.split(',')
    end

    def required_fields
      [:type, :id]
    end

    def builder_fields
      bf = _builder.fields_for(_root_name).presence
      fields = if bf.present?
                 (required_fields + Array(bf)).uniq
               else
                 default_fields ? default_fields & all_fields : all_fields
               end
      (required_fields + Array(fields)).uniq.map(&:to_sym)
    end

    class << self
      attr_reader :registered_serializers

      def register_serializer(serializer_hash, options)
        options.reverse_merge!(primary_key: :id)
        @registered_serializers ||= []
        @registered_serializers << serializer_hash.merge(options)
      end

      def for(model, association)
        return association.serializer if association.serializer.present?
        if association[:polymorphic]
          for_polymorphic(model)
        else
          for_regular(association)
        end
      end

      def includes(association)
        serializer = Serializer.for_regular(association)
        serializer._associations.reject(&:polymorphic).map do |assoc|
          assoc[:name]
        end if serializer
      end

      def for_regular(association)
        resource = association[:name].to_s.pluralize.to_sym
        serializer = @registered_serializers.find do |entry|
          entry[:resource] == resource
        end
        serializer[:serializer] if serializer
      end

      def for_polymorphic(model)
        serializer = @registered_serializers.find do |entry|
          entry[:model] == model.class
        end
        serializer[:serializer] if serializer
      end
    end
  end
end
