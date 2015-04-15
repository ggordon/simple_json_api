require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderIncludeTest' do
    it 'should match json hash for a project with include specified' do
      actual_project.must_match_json expected_project
    end

    it 'should match json hash for a project array with include specified' do
      actual_projects.must_match_json expected_projects
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        context: { base_url: 'http://example.com' },
        include: 'todolists'
      )
    end
    let(:expected_project) do
      {
        'links' => {
          'self' => 'http://example.com/projects/100'
        },
        'data' => {
          'type' => 'projects',
          'id' => '100',
          'name' => 'First Project',
          'description' => 'The first project',
          'position' => '',
          'links' => {
            'self' => 'http://example.com/projects/100',
            'todolist' => {
              'linkage' => { 'type' => 'todolists', 'id' => '200' }
            },
            'tags' => {
              'linkage' => [
                { 'type' => 'tags', 'id' => '10' }
              ]
            }
          }
        },
        'included' => [
          {
            'type' => 'todolists',
            'id' => '200',
            'description' => 'Groceries',
            'links' => {
              'self' => 'http://example.com/todolists/200',
              'todos' => {
                'linkage' => [
                  { 'type' => 'todos', 'id' => '300' },
                  { 'type' => 'todos', 'id' => '301' }
                ]
              },
              'tags' => {
                'linkage' => [
                  { 'type' => 'tags', 'id' => '30' }
                ]
              }
            }
          }
        ]
      }
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.all.to_a,
        serializer: ProjectSerializer,
        context: { base_url: 'http://example.com' },
        include: 'todolists,tags'
      )
    end
    let(:expected_projects) do
      {
        'links' => {
          'self' => 'http://example.com/projects'
        },
        'data' => [
          {
            'type' => 'projects',
            'id' => '100',
            'name' => 'First Project',
            'description' => 'The first project',
            'position' => '',
            'links' => {
              'self' => 'http://example.com/projects/100',
              'todolist' => {
                'linkage' => { 'type' => 'todolists', 'id' => '200' }
              },
              'tags' => {
                'linkage' => [
                  { 'type' => 'tags', 'id' => '10' }
                ]
              }
            }
          },
          {
            'type' => 'projects',
            'id' => '110',
            'name' => 'Second Project',
            'description' => 'The second project',
            'position' => '',
            'links' => {
              'self' => 'http://example.com/projects/110',
              'todolist' => {
                'linkage' => { 'type' => 'todolists', 'id' => '210' }
              },
              'tags' => {
                'linkage' => [
                  { 'type' => 'tags', 'id' => '20' }
                ]
              }
            }
          }
        ],
        'included' => [
          {
            'type' => 'todolists',
            'id' => '200',
            'description' => 'Groceries',
            'links' => {
              'self' => 'http://example.com/todolists/200',
              'todos' => {
                'linkage' => [
                  { 'type' => 'todos', 'id' => '300' },
                  { 'type' => 'todos', 'id' => '301' }
                ]
              },
              'tags' => {
                'linkage' => [
                  { 'type' => 'tags', 'id' => '30' }
                ]
              }
            }
          },
          {
            'type' => 'todolists',
            'id' => '210',
            'description' => 'Groceries',
            'description' => 'Work',
            'links' => {
              'self' => 'http://example.com/todolists/210',
              'todos' => {
                'linkage' => [
                  { 'type' => 'todos', 'id' => '310' },
                  { 'type' => 'todos', 'id' => '320' },
                  { 'type' => 'todos', 'id' => '330' }
                ]
              },
              'tags' => {
                'linkage' => []
              }
            }
          },
          {
            'type' => 'tags',
            'id' => '10',
            'guid' => '10',
            'name' => 'Urgent!',
            'links' => {
              'self' => 'http://example.com/tags/10',
              'taggables' => {
                'linkage' => [
                  { 'type' => 'projects', 'id' => '100' },
                  { 'type' => 'todos', 'id' => '300' },
                  { 'type' => 'todos', 'id' => '301' },
                  { 'type' => 'todos', 'id' => '330' }
                ]
              }
            }
          },
          {
            'type' => 'tags',
            'id' => '20',
            'guid' => '20',
            'name' => 'On Hold',
            'links' => {
              'self' => 'http://example.com/tags/20',
              'taggables' => {
                'linkage' => [
                  { 'type' => 'projects', 'id' => '110' }
                ]
              }
            }
          }
        ]
      }
    end
  end
end
