require 'spec_helper'

Rails::Generators.send(:lookup, ["rails:scaffold_controller"])

describe Rails::Generators::ScaffoldControllerGenerator, type: :generator do
  destination File.expand_path('../../../../tmp/generator', __FILE__)
  arguments %w(verbose)

  before { prepare_destination }

  shared_examples :rails_scaffold_controller do |controller_name|
    context controller_name do
      let(:home_dir){ File.expand_path('../../../../tmp/.model_base', __FILE__) }
      before{ allow(ModelBase.config).to receive(:home_dir).and_return(home_dir) }
      after do
        expect(File.read(File.join(home_dir, 'controllers')).strip).to eq controller_name
        FileUtils.rm_rf(home_dir)
      end

      it 'creates a test initializer' do
        run_generator [controller_name.dup]
        assert_expectation_file "app/controllers/#{controller_name}_controller.rb"
      end
    end
  end

  it_behaves_like :rails_scaffold_controller, 'projects'
  it_behaves_like :rails_scaffold_controller, 'project_assignments'
  it_behaves_like :rails_scaffold_controller, 'phases'
  it_behaves_like :rails_scaffold_controller, 'issues'
  it_behaves_like :rails_scaffold_controller, 'issue_comments'
  it_behaves_like :rails_scaffold_controller, 'attached_files'
end
