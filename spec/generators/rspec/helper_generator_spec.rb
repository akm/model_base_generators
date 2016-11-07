require 'spec_helper'

Rails::Generators.lookup(["rspec:helper"])

describe Rspec::Generators::HelperGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :rspec_helper do |controller_name|
    context controller_name do
      before{ run_generator [controller_name.dup] }

      it { assert_expectation_file "spec/helpers/#{controller_name}_helper_spec.rb" }
    end
  end

  it_behaves_like :rspec_helper, 'projects'
  it_behaves_like :rspec_helper, 'project_assignments'
  it_behaves_like :rspec_helper, 'phases'
  it_behaves_like :rspec_helper, 'issues'
  it_behaves_like :rspec_helper, 'issue_comments'
  it_behaves_like :rspec_helper, 'attached_files'
end
