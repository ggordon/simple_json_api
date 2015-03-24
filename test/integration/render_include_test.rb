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
        include: 'todolists'
      )
    end
    let(:expected_project) do
      {
        'data' => {
          'type' => 'projects',
          'id' => '100',
          'name' => 'First Project',
          'description' => 'The first project',
          'position' => '',
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
            'description' => 'Groceries',
            'links' => {
              'self' => 'http://example.com/todolists/200',
              'todos' => %w(300 301),
              'tags' => ['30']
            }
          }
        ]
      }
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.all.to_a,
        serializer: ProjectSerializer,
        include: 'todolists,tags'
      )
    end
    let(:expected_projects) do
      {
        'data' => [
          {
            'type' => 'projects',
            'id' => '100',
            'name' => 'First Project',
            'description' => 'The first project',
            'position' => '',
            'links' => {
              'self' => 'http://example.com/projects/100',
              'todolist' => '200',
              'tags' => ['10']
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
              'todolist' => '210',
              'tags' => ['20']
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
              'todos' => %w(300 301),
              'tags' => ['30']
            }
          },
          {
            'type' => 'todolists',
            'id' => '210',
            'description' => 'Groceries',
            'description' => 'Work',
            'links' => {
              'self' => 'http://example.com/todolists/210',
              'todos' => %w(310 320 330),
              'tags' => []
            }
          },
          {
            'type' => 'tags',
            'id' => '10',
            'guid' => '10',
            'name' => 'Urgent!',
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
            'type' => 'tags',
            'id' => '20',
            'guid' => '20',
            'name' => 'On Hold',
            'links' => {
              'taggables' => [
                %w(projects 110)
              ]
            }
          }
        ]
      }
    end
  end
end
