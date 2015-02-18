require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'RenderIncludeTest' do
    it 'should match json hash for a project with include specified' do
      actual_project.must_match_json expected_project.to_json
    end

    it 'should match json hash for a project array with include specified' do
      actual_projects.must_match_json expected_projects.to_json
    end

    let(:actual_project) do
      SimpleJsonApi.render(
        model: Project.first,
        serializer: ProjectSerializer,
        options: { include: 'todolists' }
      )
    end
    let(:expected_project) do
      {
        'projects' => {
          'id' => '100',
          'name' => 'First Project',
          'description' => 'The first project',
          'position' => '',
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
              'description' => 'Groceries',
              'href' => 'http://example.com/todolists/200',
              'links' => {
                'todos' => %w(300 301),
                'tags' => ['30']
              }
            }
          ]
        }

      }
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.all.to_a,
        serializer: ProjectSerializer,
        options: { include: 'todolists,tags' }
      )
    end
    let(:expected_projects) do
      {
        'projects' => [
          {
            'id' => '100',
            'name' => 'First Project',
            'description' => 'The first project',
            'position' => '',
            'href' => 'http://example.com/projects/100',
            'links' => {
              'todolist' => '200',
              'tags' => ['10']
            }
          },
          {
            'id' => '110',
            'name' => 'Second Project',
            'description' => 'The second project',
            'position' => '',
            'href' => 'http://example.com/projects/110',
            'links' => {
              'todolist' => '210',
              'tags' => ['20']
            }
          }
        ],
        'linked' => {
          'todolists' => [
            {
              'id' => '200',
              'description' => 'Groceries',
              'href' => 'http://example.com/todolists/200',
              'links' => {
                'todos' => %w(300 301),
                'tags' => ['30']
              }
            },
            {
              'id' => '210',
              'description' => 'Groceries',
              'description' => 'Work',
              'href' => 'http://example.com/todolists/210',
              'links' => {
                'todos' => %w(310 320 330),
                'tags' => []
              }
            }
          ],
          'tags' => [
            {
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
      }
    end
  end
end
