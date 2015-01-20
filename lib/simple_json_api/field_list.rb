# SimpleJsonApi
module SimpleJsonApi
  # List of Fields for a resource
  class FieldList
    def initialize(fields, root_serializer)
      @fields = fields
      @root_serializer = root_serializer
    end

    def field_list
      @field_list ||= parse
    end

    def parse
      result = {}
      case @fields
      when Hash
        @fields.each do |resource, fields|
          result[resource.to_sym] = FIELD_LIST_PARSER.call(fields)
        end
      when String
        result[@root_serializer._root_name] = FIELD_LIST_PARSER.call(@fields)
      end
      result
    end

    def fields_for(resource)
      field_list.fetch(resource, nil)
    end

    FIELD_LIST_PARSER = ->(list) { list.split(',').map(&:to_s) }
  end
end
