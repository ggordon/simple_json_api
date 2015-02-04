require 'simple_json_api/refinements/symbol'

module SimpleJsonApi
  # Node in the directed graph of associations (eventually)
  # Will start as a tree with duplication
  class ApiNode
    using Refinements::Symbol

    def initialize(name, serializer, model, assoc_list)
      @name = name
      @serializer = serializer
      @model = model
      @assoc_list = assoc_list
      @associations = [] # list of api_nodes
    end

    def load
      return self unless @serializer._associations
      @serializer._associations.each do |association|
        ap "--- #{association}"
        add_association(association)
      end
      self
    end

    def add_association(association)
      name = association[:name]
      plural_name = name.pluralize
      return unless @assoc_list.key? plural_name
      model = model_from_serializer(name)
      serializer = serializer_from_model(association, model)
      ap "   +++ #{plural_name} #{model} #{serializer}"
      self <<
        ApiNode.new(
          plural_name, serializer, model, @assoc_list[plural_name]
        ).load
    end

    def serializer_from_model(association, model)
      if model.is_a? Array
        ap '+++++ adding Array'
        ap "+++++ adding #{@serializer.inspect}"
        serializer_klass = @serializer._each_serializer
        ap "+++++ adding #{serializer_klass}"

        ArraySerializer.new(model, @serializer._builder, serializer_klass)
      else
        ap '+++++ adding Resource'
        serializer_klass = Serializer.for(model, association)
        ap "+++++ adding #{@serializer.inspect}"
        ap "+++++ adding #{serializer_klass}"

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
