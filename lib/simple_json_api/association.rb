# SimpleJsonApi
module SimpleJsonApi
  # Wrapper for an included association
  Association = Struct.new(:name, :type, :serializer, :polymorphic, :key) do
    using Refinements::Symbol

    def key
      name_s = name.to_s
      (type == :has_many) ? name_s.pluralize.to_sym : name_s.singularize.to_sym
    end

    def plural_name
      name.pluralize
    end
  end
end
