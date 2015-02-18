require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderNestedIncludeTest' do
    it 'should match json hash for a project with nested includes specified' do
      actual_project.must_match_json expected_project.to_json
      # ap '_' * 20
      # ObjectSpace.each_object(ApiNode).each { |an| ap an.name }
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        options: {
          include: 'todolists'\
                 ',todolists.todos'\
                 ',todolists.todos.tags'\
                 ',todolists.todos.tags.taggables',
          fields: { projects: 'id', todolists: 'id', todos: 'id', tags: 'guid' }
        }
      )
    end
    let(:expected_project) do
      {
        'projects' => {
          'id' => '100',
          'href' => 'http://example.com/projects/100',
          'links' => {
            'todolist' => '200',
            'tags' => ['10']
          }
        },
        'linked' => {
          'todolists' => [
            {
              'id' => '200',
              'href' => 'http://example.com/todolists/200',
              'links' => {
                'todos' => %w(300 301),
                'tags' => ['30']
              }
            },
            {
              'id' => '200',
              'href' => 'http://example.com/todolists/200',
              'links' => {
                'todos' => %w(300 301),
                'tags' => ['30']
              }
            }
          ],
          'todos' => [
            {
              'id' => '300',
              'href' => 'http://example.com/todos/300',
              'links' => {
                'tags' => %w(10 30)
              }
            },
            {
              'id' => '301',
              'href' => 'http://example.com/todos/301',
              'links' => {
                'tags' => %w(10)
              }
            },
            {
              'id' => '330',
              'href' => 'http://example.com/todos/330',
              'links' => {
                'tags' => ['10']
              }
            },
            # FIXME: duplicate!!!!!
            {
              'id' => '300',
              'href' => 'http://example.com/todos/300',
              'links' => {
                'tags' => %w(10 30)
              }
            }
          ],
          'tags' => [
            {
              'guid' => '10',
              'links' => {
                'taggables' => [
                  %w(projects 100),
                  %w(todos 300),
                  %w(todos 301),
                  %w(todos 330)
                ]
              }
            },
            {
              'guid' => '30',
              'links' => {
                'taggables' => [
                  %w(todolists 200),
                  %w(todos 300)
                ]
              }
            }
          ],
          'projects' => [
            {
              'id' => '100',
              'href' => 'http://example.com/projects/100',
              'links' => {
                'todolist' => '200',
                'tags' => [
                  '10'
                ]
              }
            }
          ]
        }
      }
    end
  end
end
