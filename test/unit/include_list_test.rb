require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'IncludeListTest' do
    it 'should parse string include list' do
      il = IncludeList.new('todos,projects').parse
      expected = {
        todos: {
          include: true
        },
        projects: {
          include: true
        }
      }
      il.include_hash.must_equal expected
    end

    it 'should parse string for nested include list' do
      il = IncludeList.new('todos,projects.todolists').parse
      expected = {
        todos: {
          include: true
        },
        projects: {
          todolists: {
            include: true
          }
        }
      }
      il.include_hash.must_equal expected
    end

    it 'should parse string for nested include list skipping middle' do
      il = IncludeList.new('todolist,todolist.todos.tags').parse
      expected = {
        todolists: {
          include: true,
          todos: {
            tags: {
              include: true
            }
          }
        }
      }
      il.include_hash.must_equal expected
    end
  end
end
