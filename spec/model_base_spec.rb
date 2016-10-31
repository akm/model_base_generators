require "spec_helper"

describe ModelBase do
  it "has a version number" do
    expect(ModelBase::VERSION).not_to be nil
  end

  describe :skipped_file? do
    subject{ ModelBase }

    context :with_specified_filename do
      before do
        expect(ModelBase.config).to receive(:skipped_files).and_return(['app/views/projects/show.html.erb'])
      end
      it{ expect(subject.skipped_file?('app/views/projects/show.html.erb')).to be_truthy }
      it{ expect(subject.skipped_file?('app/views/projects/index.html.erb')).to be_falsy }
    end

    context :with_single_astarisk do
      before do
        expect(ModelBase.config).to receive(:skipped_files).and_return(['app/views/projects/*'])
      end
      it{ expect(subject.skipped_file?('app/views/projects/index.html.erb')).to be_truthy }
      it{ expect(subject.skipped_file?('app/views/issues/index.html.erb')).to be_falsy }
    end

    context :with_double_astarisk do
      before do
        expect(ModelBase.config).to receive(:skipped_files).and_return(['app/**/project*'])
      end
      it{ expect(subject.skipped_file?('app/models/project.rb')).to be_truthy }
      it{ expect(subject.skipped_file?('app/controllers/projects_controller.rb')).to be_truthy }
      it{ expect(subject.skipped_file?('app/views/projects/index.html.erb')).to be_truthy }
      it{ expect(subject.skipped_file?('app/views/issues/index.html.erb')).to be_falsy }
    end

  end
end
