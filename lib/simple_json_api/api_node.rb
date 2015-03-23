require 'simple_json_api/refinements/symbol'

module SimpleJsonApi
  # Node in the directed graph of associations (eventually)
  # Will start as a tree with duplication
  class ApiNode
    extend Forwardable
    def_delegators :serializer, :serialize

    attr_reader :name
    attr_reader :serializer
    attr_reader :associations
    attr_reader :assoc_list

    def initialize(name, serializer, assoc_list, each_serializer = nil)
      @name = name
      @serializer = serializer
      @each_serializer = each_serializer
      @assoc_list = assoc_list
      @associations = [] # list of api_nodes
    end

    def collection?
      @serializer.is_a? ArraySerializer
    end

    def load
      return self unless serializer_actual._associations
      serializer_actual._associations.each do |association|
        add_association(association)
      end
      self
    end

    def serializer_actual
      @serializer_actual ||= @each_serializer || self.serializer
    end

    def add_association(association)
      return unless @assoc_list.key? association.plural_name
      resource = serializer.associated_object(association.name)
      Array(resource).each do |object|
        each_serializer = Serializer.for(object, association)
        serializer = SerializerFactory.create(
          object, each_serializer, self.serializer._builder
        )
        self <<
          ApiNode.new(
            association.plural_name,
            serializer,
            @assoc_list[association.plural_name],
            serializer._each_serializer
          ).load
      end
    end

    def <<(node)
      add_assoc(node)
    end

    def add_assoc(node)
      @associations << node
    end

    # def display(offset = '')
    #   ap "DISPLAY: #{offset}#{@name}, #{@assoc_list}, #{Array(@object).first.class}, #{Array(@object).map(&:id)}"
    #   @associations.each do |assoc|
    #     assoc.display(offset + '  ')
    #   end
    # end
  end
end
