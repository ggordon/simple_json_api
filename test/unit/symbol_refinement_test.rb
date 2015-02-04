require 'test_helper'
require 'simple_json_api/refinements/symbol'

# SimpleJsonApi
module SimpleJsonApi
  describe 'SymbolRefinementTest' do
    using Refinements::Symbol
    it 'should pluralize a symbol' do
      :dog.pluralize.must_equal(:dogs)
    end

    it 'should singularize a symbol' do
      :dogs.singularize.must_equal(:dog)
    end
  end
end
