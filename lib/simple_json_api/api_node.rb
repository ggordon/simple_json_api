require 'simple_json_api/refinements/symbol'

module SimpleJsonApi
  # Node in the directed graph of associations (eventually)
  # Will start as a tree with duplication
  class ApiNode
    attr_reader :name
    using Refinements::Symbol

    # module Visiting
    #   def self.default_visitor
    #     ->(*, &block) { block.call }
    #   end
    # end

    def initialize(name, serializer, model, assoc_list, each_serializer = nil)
      @name = name
      @serializer = serializer
      @each_serializer = each_serializer
      @model = model
      @assoc_list = assoc_list
      @associations = [] # list of api_nodes

      ap "!!! #{@name}"
      ap "!!!!! #{@serializer}"
      ap "!!!!! #{@serializer._each_serializer}"
      ap "!!!!! #{@model}"
      ap "!!!!! #{@assoc_list}"
    end

    def load
      serializer = @each_serializer || @serializer
      return self unless serializer._associations
      serializer._associations.each do |association|
        add_association(association)
      end
      ap '=' * 20
      ap display
      self
    end

    def add_association(association)
      name = association[:name]
      plural_name = name.pluralize
      return unless @assoc_list.key? plural_name
      model = model_from_serializer(name)
      serializer = serializer_from_model(association, model)
      self <<
        ApiNode.new(
          plural_name, serializer, model, @assoc_list[plural_name], serializer._each_serializer
        ).load
    end

    def serializer_from_model(association, model)
      if model.is_a? Array
        serializer_klass = Serializer.for(model.first, association)
        ArraySerializer.new(model, @serializer._builder, serializer_klass)
      else
        serializer_klass = Serializer.for(model, association)
        serializer_klass.new(model, @serializer._builder)
      end
    end

    def model_from_serializer(name)
      if @serializer.is_a? ArraySerializer
        @serializer.serializers.map { |s| s.send(name) }
      else
        @serializer.send(name)
      end
    end

    def <<(node)
      add_assoc(node)
    end

    def add_assoc(node)
      @associations << node
    end

    def display(offset = '')
      ap "DISPLAY: #{offset}#{@name}, #{@assoc_list}, #{Array(@model).first.class}"
      @associations.each do |assoc|
        ap "#{offset} Assoc: #{assoc}"
        assoc.display(offset + '  ')
      end
    end
  end
end
