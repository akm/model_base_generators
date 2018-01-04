require 'spec_helper'

Rails::Generators.send(:lookup, ["rspec:scaffold"])

describe Rspec::Generators::ScaffoldGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :rspec_scaffold do |controller_name|
    context controller_name do
      before{ run_generator [controller_name.dup] }

      it { assert_expectation_file "spec/controllers/#{controller_name}_controller_spec.rb" }
      it { assert_expectation_file "spec/routing/#{controller_name}_routing_spec.rb" }
      it { assert_expectation_file "spec/views/#{controller_name}/edit.html.erb_spec.rb" }
      it { assert_expectation_file "spec/views/#{controller_name}/index.html.erb_spec.rb" }
      it { assert_expectation_file "spec/views/#{controller_name}/new.html.erb_spec.rb" }
      it { assert_expectation_file "spec/views/#{controller_name}/show.html.erb_spec.rb" }
    end
  end

  it_behaves_like :rspec_scaffold, 'projects'
  it_behaves_like :rspec_scaffold, 'project_assignments'
  it_behaves_like :rspec_scaffold, 'phases'
  it_behaves_like :rspec_scaffold, 'issues'
  it_behaves_like :rspec_scaffold, 'issue_comments'
  it_behaves_like :rspec_scaffold, 'attached_files'
end
