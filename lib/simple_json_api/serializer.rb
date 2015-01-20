# SimpleJsonApi
module SimpleJsonApi
  # The Serializer will serialize a model
  class Serializer
    extend Forwardable
    extend DSL

    attr_reader :_builder
    attr_reader :_each_serializer
    attr_reader :_object

    def initialize(object, builder, each_serializer = nil, base = nil)
      @_object = object
      @_builder = builder
      @_each_serializer = each_serializer
      @_base = base
    end

    class << self
      attr_reader :registered_serializers

      def register_serializer(serializer_hash, options)
        options.reverse_merge!(primary_key: :id)
        @registered_serializers ||= []
        @registered_serializers << serializer_hash.merge(options)
      end

      def for(model, association)
        if association[:polymorphic]
          for_polymorphic(model)
        else
          for_regular(association)
        end
      end

      def for_regular(association)
        resource = association[:name].to_s.pluralize.to_sym
        serializer = @registered_serializers.find do |entry|
          entry[:resource] == resource
        end
        serializer[:serializer]
      end

      def for_polymorphic(model)
        serializer = @registered_serializers.find do |entry|
          entry[:model] == model.class
        end
        serializer[:serializer]
      end
    end
  end
end
