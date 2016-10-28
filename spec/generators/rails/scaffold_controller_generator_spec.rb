require 'spec_helper'

Rails::Generators.lookup(["rails:scaffold_controller"])

describe Rails::Generators::ScaffoldControllerGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :rails_scaffold_controller do |controller_name|
    context controller_name do
      it 'creates a test initializer' do
        run_generator [controller_name.dup]
        assert_expectation_file "app/controllers/#{controller_name}_controller.rb"
      end
    end
  end

  it_behaves_like :rails_scaffold_controller, 'projects'
  it_behaves_like :rails_scaffold_controller, 'project_assignments'
  it_behaves_like :rails_scaffold_controller, 'phases'
  it_behaves_like :rails_scaffold_controller, 'issues'
  it_behaves_like :rails_scaffold_controller, 'issue_comments'
end
