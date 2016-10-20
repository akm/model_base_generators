require 'spec_helper'

Rails::Generators.lookup(["erb:scaffold"])

describe Erb::Generators::ScaffoldGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :erb_scaffold do |controller_name|
    context controller_name do
      before{ run_generator [controller_name.dup] }

      it{ assert_expectation_file "app/views/#{controller_name}/_form.html.erb" }
      it{ assert_expectation_file "app/views/#{controller_name}/edit.html.erb" }
      it{ assert_expectation_file "app/views/#{controller_name}/index.html.erb" }
      it{ assert_expectation_file "app/views/#{controller_name}/new.html.erb" }
      it{ assert_expectation_file "app/views/#{controller_name}/show.html.erb" }
    end
  end

  it_behaves_like :erb_scaffold, 'users'
  it_behaves_like :erb_scaffold, 'projects'
  it_behaves_like :erb_scaffold, 'issues'
end
