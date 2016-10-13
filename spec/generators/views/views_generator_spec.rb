require 'spec_helper'

require 'generators/model_base/views/views_generator'

describe ModelBase::Generators::ViewsGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }

  it 'creates a test initializer' do
    run_generator %w(projects)

    assert_file 'app/views/projects/_form.html.erb', /\<\%\= form_for.*\%\>/
    assert_file 'app/views/projects/edit.html.erb', /render 'projects\/form'/
    assert_file 'app/views/projects/index.html.erb', /\<table.*\>/
    assert_file 'app/views/projects/new.html.erb', /render 'projects\/form'/
    assert_file 'app/views/projects/show.html.erb', /\<dl .*\>/
  end

  it 'creates a test initializer' do
    run_generator %w(issues)

    assert_file 'app/views/issues/_form.html.erb' do |c|
      expect(c).to match /\<\%\= form_for.*\%\>/
      expect(c).to include '<%= f.collection_select :project_id, Project.all, :id, :name, {}, :class=>"form-control" %>'
      expect(c).to include '<%= f.select :status, ::Issue.status.optoins %>'
    end
    assert_file 'app/views/issues/edit.html.erb', /render 'issues\/form'/
    assert_file 'app/views/issues/index.html.erb' do |c|
      expect(c).to match /\<table.*\>/
      expect(c).to include '<%= issue.project.name %>'
      expect(c).to include '<%= issue.status %>'
    end
    assert_file 'app/views/issues/new.html.erb', /render 'issues\/form'/
    assert_file 'app/views/issues/show.html.erb' do |c|
      expect(c).to match /\<dl .*\>/
      expect(c).to include '<%= @issue.project_id %>'
      expect(c).to include '<%= @issue.status %>'
    end
  end
end
