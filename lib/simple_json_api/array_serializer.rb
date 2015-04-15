# SimpleJsonApi
module SimpleJsonApi
  # The ArraySerializer will serialize a collection
  class ArraySerializer < Serializer
    def serialize
      _object.map do |object|
        serializer = _each_serializer.new(object, _builder, _context)
        Resource.new(serializer.serialize)
      end
    end

    def associated_object(association_name)
      serializers.map { |serializer| serializer.send(association_name) }
    end

    def _root_name
      _each_serializer._root_name
    end

    def _associations
      _each_serializer._associations if _each_serializer
    end

    def serializers
      _object.map do |object|
        _each_serializer.new(object, _builder, _context)
      end
    end

    def href
      _context[:base_url] + "/#{_root_name}"
    end
  end
end
