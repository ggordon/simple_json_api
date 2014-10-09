require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderNestedIncludeTest' do
    it 'should match json hash for a project with nested includes specified' do
      compare_json(actual_project, expected_project.to_json)
      JSON.parse(actual_project).must_equal expected_project
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
                'todos' => ['300'],
                'tags' => ['30']
              }
            }
          ],
          'todos' => [
            {
              'id' => '300',
              'href' => 'http://example.com/todos/300',
              'links' => {
                'tags' => %w(10 20)
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
                'tags' => %w(10 20)
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
                  %w(todos 330)
                ]
              }
            },
            {
              'guid' => '20',
              'links' => {
                'taggables' => [
                  %w(projects 110),
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
            },
            {
              'id' => '110',
              'href' => 'http://example.com/projects/110',
              'links' => {
                'todolist' => '210',
                'tags' => [
                  '20'
                ]
              }
            }
          ]
        }
      }
    end
  end
end
