require 'test_helper'

# SimpleJsonApi
module SimpleJsonApi
  describe 'ValidatorTest' do
    describe 'valid data should pass' do
      it "has valid 'data' resource" do
        json = {
          'data' => { 'id' => '1', 'type' => 'User' }
        }.to_json
        assert SimpleJsonApi::Validator.new.validate(json)
      end

      it "has valid 'data' array" do
        json = {
          'data' => [
            { 'id' => '1', 'type' => 'User' },
            { 'id' => '2', 'type' => 'User' }
          ]
        }.to_json
        assert SimpleJsonApi::Validator.new.validate(json)
      end
    end
  end
end
