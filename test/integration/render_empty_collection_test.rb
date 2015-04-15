require 'test_helper'

module SimpleJsonApi
  describe 'RenderEmptyCollectionTest' do
    it 'should match json hash for a project array with no projects' do
      actual_projects.must_match_json expected_projects
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.none.to_a,
        serializer: ProjectSerializer,
        context: { base_url: 'http://example.com' }
      )
    end
    let(:expected_projects) do
      {
        'links' => {
          'self' => 'http://example.com/projects'
        },
        'data' => []
      }
    end
  end
end