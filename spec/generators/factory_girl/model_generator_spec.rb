require 'spec_helper'

Rails::Generators.lookup(["rails:scaffold_controller"])

describe Rails::Generators::ScaffoldControllerGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :factory_girl_model do |model_name|
    context model_name do
      it 'creates a test initializer' do
        run_generator [model_name.dup]
        assert_expectation_file "spec/factories/#{model_name.pluralize}.rb"
      end
    end
  end

  it_behaves_like :factory_girl_model, 'project'
  it_behaves_like :factory_girl_model, 'issue'
end
