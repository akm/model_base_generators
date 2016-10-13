require 'spec_helper'

Rails::Generators.lookup(["rails:scaffold_controller"])

describe Rails::Generators::ScaffoldControllerGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  it 'creates a test initializer' do
    run_generator %w(issues)

    assert_expectation_file 'app/controllers/issues_controller.rb'
  end
end
