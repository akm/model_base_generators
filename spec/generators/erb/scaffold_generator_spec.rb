require 'spec_helper'

Rails::Generators.lookup(["erb:scaffold"])

describe Erb::Generators::ScaffoldGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  it 'creates a test initializer' do
    run_generator %w(projects)

    assert_expectation_file 'app/views/projects/_form.html.erb'
    assert_expectation_file 'app/views/projects/edit.html.erb'
    assert_expectation_file 'app/views/projects/index.html.erb'
    assert_expectation_file 'app/views/projects/new.html.erb'
    assert_expectation_file 'app/views/projects/show.html.erb'
  end

  it 'creates a test initializer' do
    run_generator %w(issues)

    assert_expectation_file 'app/views/issues/_form.html.erb'
    assert_expectation_file 'app/views/issues/edit.html.erb'
    assert_expectation_file 'app/views/issues/index.html.erb'
    assert_expectation_file 'app/views/issues/new.html.erb'
    assert_expectation_file 'app/views/issues/show.html.erb'
  end
end
