require 'spec_helper'

Rails::Generators.lookup(["rspec:scaffold"])

describe Rspec::Generators::ScaffoldGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  it 'issues' do
    run_generator %w(issues)

    assert_expectation_file 'spec/controllers/issues_controller_spec.rb'
    assert_expectation_file 'spec/routing/issues_routing_spec.rb'
    assert_expectation_file 'spec/views/issues/edit.html.erb_spec.rb'
    assert_expectation_file 'spec/views/issues/index.html.erb_spec.rb'
    assert_expectation_file 'spec/views/issues/new.html.erb_spec.rb'
    assert_expectation_file 'spec/views/issues/show.html.erb_spec.rb'
  end

  it 'projects' do
    run_generator %w(projects)

    assert_expectation_file 'spec/controllers/projects_controller_spec.rb'
    assert_expectation_file 'spec/routing/projects_routing_spec.rb'
    assert_expectation_file 'spec/views/projects/edit.html.erb_spec.rb'
    assert_expectation_file 'spec/views/projects/index.html.erb_spec.rb'
    assert_expectation_file 'spec/views/projects/new.html.erb_spec.rb'
    assert_expectation_file 'spec/views/projects/show.html.erb_spec.rb'
  end
end
