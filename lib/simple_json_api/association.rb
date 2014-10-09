# SimpleJsonApi
module SimpleJsonApi
  # Wrapper for a linked association
  Association = Struct.new(:name, :type, :serializer, :polymorphic, :key) do
    def key
      name_s = name.to_s
      (type == :has_many) ? name_s.pluralize.to_sym : name_s.singularize.to_sym
    end
  end
end
