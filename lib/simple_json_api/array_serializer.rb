# SimpleJsonApi
module SimpleJsonApi
  # The ArraySerializer will serialize a collection
  class ArraySerializer < Serializer
    def serialize
      _object.map do |object|
        serializer = _each_serializer.new(object, _builder)
        serializer.serialize
      end
    end

    def _root_name
      _each_serializer._root_name
    end

    def _associations
      _each_serializer._associations if _each_serializer
    end

    def serializers
      _object.map do |object|
        _each_serializer.new(object, _builder)
      end
    end
  end
end
