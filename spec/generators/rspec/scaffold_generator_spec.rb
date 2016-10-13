require 'spec_helper'

Rails::Generators.lookup(["rspec:scaffold"])

describe Rspec::Generators::ScaffoldGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  it 'creates a test initializer' do
    run_generator %w(issues)

    assert_expectation_file 'spec/controllers/issues_controller_spec.rb'
    assert_expectation_file 'spec/routing/issues_routing_spec.rb'
    assert_expectation_file 'spec/views/issues/edit.html.erb_spec.rb'
    assert_expectation_file 'spec/views/issues/index.html.erb_spec.rb'
    assert_expectation_file 'spec/views/issues/new.html.erb_spec.rb'
    assert_expectation_file 'spec/views/issues/show.html.erb_spec.rb'
  end
end
