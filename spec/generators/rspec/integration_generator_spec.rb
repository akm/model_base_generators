require 'spec_helper'

Rails::Generators.lookup(["rspec:integration"])

describe Rspec::Generators::IntegrationGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :rspec_integration do |controller_name|
    context controller_name do
      before{ run_generator [controller_name.singularize] }

      it { assert_expectation_file "spec/requests/#{controller_name}_spec.rb" }
    end
  end

  it_behaves_like :rspec_integration, 'projects'
  it_behaves_like :rspec_integration, 'project_assignments'
  it_behaves_like :rspec_integration, 'phases'
  it_behaves_like :rspec_integration, 'issues'
  it_behaves_like :rspec_integration, 'issue_comments'
end
