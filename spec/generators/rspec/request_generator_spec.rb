require 'spec_helper'

Rails::Generators.lookup(["rspec:request"])

describe Rspec::Generators::RequestGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :rspec_request do |controller_name|
    context controller_name do
      before{ run_generator [controller_name.dup] }

      it { assert_expectation_file "spec/requests/#{controller_name}_spec.rb" }
    end
  end

  it_behaves_like :rspec_request, 'projects'
  it_behaves_like :rspec_request, 'project_assignments'
  it_behaves_like :rspec_request, 'phases'
  it_behaves_like :rspec_request, 'issues'
  it_behaves_like :rspec_request, 'issue_comments'
end
