require 'test_helper'

module SimpleJsonApi
  describe 'RenderEmptyCollectionTest' do
    it 'should match json hash for a project array with no projects' do
      actual_projects.must_match_json expected_projects
    end

    let(:actual_projects) do
      SimpleJsonApi.render(
        model: Project.none.to_a,
        serializer: ProjectSerializer
      )
    end
    let(:expected_projects) do
      {
        'data' => []
      }
    end
  end
end
