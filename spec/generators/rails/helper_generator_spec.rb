require 'spec_helper'

Rails::Generators.lookup(["rails:helper"])

describe Rails::Generators::HelperGenerator, type: :generator do
  destination File.expand_path('../../../../tmp/generator', __FILE__)
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :rails_helper do |controller_name|
    context controller_name do
      let(:home_dir){ File.expand_path('../../../../tmp/generator', __FILE__) }
      before{ allow(ModelBase.config).to receive(:home_dir).and_return(home_dir) }
      after do
        FileUtils.rm_rf(home_dir)
      end

      it 'creates a test initializer' do
        run_generator [controller_name.dup]
        assert_expectation_file "app/helpers/#{controller_name}_helper.rb"
      end
    end
  end

  it_behaves_like :rails_helper, 'projects'
  it_behaves_like :rails_helper, 'project_assignments'
  it_behaves_like :rails_helper, 'phases'
  it_behaves_like :rails_helper, 'issues'
  it_behaves_like :rails_helper, 'issue_comments'
end
