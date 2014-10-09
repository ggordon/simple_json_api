require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'IncludeListTest' do
    it 'should parse string include list' do
      il = IncludeList.new(
        include: 'todos,projects'
      ).parse
      assert il.include?(:projects)
      refute il.include?(:todo_lists)
    end

    it 'should parse string for nested include list' do
      il = IncludeList.new(
        include: 'todos,projects.todolists'
      ).parse
      refute il.include?(:projects)
      assert il.include?(:todos)
      assert il.include?(:todolists, [:projects])
    end
  end
end
