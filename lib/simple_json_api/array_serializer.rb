# SimpleJsonApi
module SimpleJsonApi
  # The ArraySerializer will serialize a collection
  class ArraySerializer < Serializer
    def serialize
      _object.map do |object|
        serializer = _each_serializer.new(object: object, builder: _builder)
        serializer.serialize
      end
    end

    def _root_name
      _each_serializer._root_name
    end
  end
end
