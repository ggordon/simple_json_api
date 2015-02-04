# SimpleJsonApi
module SimpleJsonApi
  # List of Included associations for a resource
  class IncludeList
    attr_reader :include_hash

    def initialize(include)
      @include = include
      # autovivificious hash
      @include_hash = Hash.new do |hash, key|
        hash[key] = Hash.new(&hash.default_proc)
      end
    end

    def parse
      @include.split(',').each do |a|
        inc = a.split('.').inject(@include_hash) do |hash, key|
          hash[key.pluralize.to_sym]
        end
        inc[:include] = true
      end if @include
      self
    end
  end
end
