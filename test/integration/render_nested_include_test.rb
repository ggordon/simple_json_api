require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderNestedIncludeTest' do
    it 'should match json hash for a project with nested includes specified' do
      actual_project.must_match_json expected_project
      # ap '_' * 20
      # ObjectSpace.each_object(ApiNode).each { |an| ap an.name }
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        include: 'todolists'\
                 ',todolists.todos'\
                 ',todolists.todos.tags.taggables',
        fields: { projects: 'id', todolists: 'id', todos: 'id', tags: 'guid' }
      )
    end
    let(:expected_project) do
      {
        'data' => {
          'type' => 'projects',
          'id' => '100',
          'links' => {
            'self' => 'http://example.com/projects/100',
            'todolist' => '200',
            'tags' => ['10']
          }
        },
        'included' => [
          {
            'type' => 'todolists',
            'id' => '200',
            'links' => {
              'self' => 'http://example.com/todolists/200',
              'todos' => %w(300 301),
              'tags' => ['30']
            }
          },
          {
            'type' => 'todos',
            'id' => '300',
            'links' => {
              'self' => 'http://example.com/todos/300',
              'tags' => %w(10 30)
            }
          },
          {
            'type' => 'todos',
            'id' => '301',
            'links' => {
              'self' => 'http://example.com/todos/301',
              'tags' => %w(10)
            }
          },
          {
            'type' => 'todos',
            'id' => '330',
            'links' => {
              'self' => 'http://example.com/todos/330',
              'tags' => %w(10)
            }
          }
        ]
      }
    end
  end
end
