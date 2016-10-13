require 'spec_helper'

require 'generators/model_base/controller/controller_generator'

describe ModelBase::Generators::ControllerGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  it 'creates a test initializer' do
    run_generator %w(issues)

    assert_file 'app/controllers/issues_controller.rb', File.read(File.expand_path('../expections/issues_controller.rb', __FILE__))
  end
end
