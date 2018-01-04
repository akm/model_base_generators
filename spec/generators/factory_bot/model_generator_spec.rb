require 'spec_helper'

Rails::Generators.lookup(["rails:scaffold_controller"])

describe FactoryBot::Generators::ModelGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :factory_bot_model do |model_name|
    context model_name do
      it 'creates a test initializer' do
        run_generator [model_name.dup, '--dir=spec/factories']
        assert_expectation_file "spec/factories/#{model_name.pluralize}.rb"
      end
    end
  end

  it_behaves_like :factory_bot_model, 'project'
  it_behaves_like :factory_bot_model, 'project_assignment'
  it_behaves_like :factory_bot_model, 'phase'
  it_behaves_like :factory_bot_model, 'issue'
  it_behaves_like :factory_bot_model, 'issue_comment'
  it_behaves_like :factory_bot_model, 'attached_file'
end
