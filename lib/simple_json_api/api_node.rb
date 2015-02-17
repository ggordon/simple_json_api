require 'simple_json_api/refinements/symbol'

module SimpleJsonApi
  # Node in the directed graph of associations (eventually)
  # Will start as a tree with duplication
  class ApiNode
    attr_reader :name

    # using Refinements::Symbol

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
    end

    def load
      serializer = @each_serializer || @serializer
      return self unless serializer._associations
      serializer._associations.each do |association|
        add_association(association)
      end
      self
    end

    def add_association(association)
      return unless @assoc_list.key? association.plural_name

      object = @serializer.associated_object(association.name)
      each_serializer = Serializer.for(object, association)
      serializer = SerializerFactory.create(
        object, each_serializer, @serializer._builder
      )
      self <<
        ApiNode.new(
          association.plural_name,
          serializer,
          object,
          @assoc_list[association.plural_name],
          serializer._each_serializer
        ).load
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
