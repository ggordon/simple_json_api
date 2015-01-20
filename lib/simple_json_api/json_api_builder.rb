# SimpleJsonApi
module SimpleJsonApi
  # The Builder to walk the hierarchy and contruct the JSON
  class JsonApiBuilder
    using ActiveRecordRefinements
    using ArrayRefinements

    extend Forwardable

    attr_reader :serializer
    attr_reader :model
    attr_reader :_included_resources
    attr_reader :include
    attr_reader :field_list
    attr_reader :result

    def_delegators :@field_list, :fields_for

    # TODO: sort: nil
    def initialize(model, serializer, options = {})
      @model = model
      handle_options(options, serializer)
      @serializer = get_serializer(serializer)
      @_included_resources = {}
      @result = {}
      @linked = {}
    end

    def handle_options(options, serializer)
      @field_list = FieldList.new(
        options.fetch(:fields, nil),
        serializer
      )
      @include = IncludeList.new(options.fetch(:include, nil)).parse
    end

    def as_json(options = nil)
      build.as_json(options)
    end

    def build
      result[@serializer._root_name] = @serializer.serialize
      @result[:linked] = @linked unless @linked.empty?
      @result
    end

    def add_linked_elem(elem, obj, association, base)
      resource_name = elem.to_s.pluralize
      obj = Array(obj) unless obj.respond_to?(:each)
      obj.each do |item|
        serialize_association(item, resource_name, association, base)
      end
    end

    def serialize_association(item, resource_name, association, base)
      # TODO: don't include middle unless explicitly requested.
      return unless include.include?(resource_name, base)
      assoc_base = [base, resource_name].compact.join('.')
      serializer = ResourceSerializer.for(item, association)
      add_to_linked(assoc_base, item, serializer)
    end

    def add_to_linked(assoc_base, item, serializer)
      linked = @linked[serializer._root_name] ||= []
      return if linked.already_linked?(item.json_pk, item.json_id)
      linked << serializer.new(item, self, nil, assoc_base).serialize
    end

    private

    def get_serializer(serializer)
      if use_array_serializer?
        ArraySerializer.new(@model, self, serializer)
      else
        serializer.new(@model, self)
      end
    end

    def use_array_serializer?
      @model.is_a?(Array) ||
        @model.is_a?(ActiveRecord::Associations::CollectionProxy)
    end
  end
end
