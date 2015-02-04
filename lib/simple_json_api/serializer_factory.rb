require 'simple_json_api/serializer'
require 'simple_json_api/array_serializer'
require 'simple_json_api/resource_serializer'

# SimpleJsonApi
module SimpleJsonApi
  # The SerializerFactory will return the serializer for an object
  class SerializerFactory
    def self.create(object, serializer, builder)
      if use_array_serializer?(object)
        ArraySerializer.new(object, builder, serializer)
      else
        serializer.new(object, builder)
      end
    end

    def self.use_array_serializer?(object)
      object.is_a?(Array) ||
        object.is_a?(ActiveRecord::Associations::CollectionProxy)
    end
  end
end
