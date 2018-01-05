require "spec_helper"

describe ModelBase::MetaModel do
  describe :names do
    context :project do
      subject{ ModelBase::MetaModel.new('Project') }
      its(:name){ is_expected.to eq 'Project' }
      its(:class_name){ is_expected.to eq subject.name }
      its(:plural_name){ is_expected.to eq 'Projects' }
      its(:resource_name){ is_expected.to eq 'project' }
      its(:plural_resource_name){ is_expected.to eq 'projects' }
      its(:full_resource_name){ is_expected.to eq 'project' }
      its(:plural_full_resource_name){ is_expected.to eq 'projects' }
    end

    context :with_module do
      subject{ ModelBase::MetaModel.new('Space::Project') }
      its(:name){ is_expected.to eq 'Space::Project' }
      its(:class_name){ is_expected.to eq subject.name }
      its(:plural_name){ is_expected.to eq 'Space::Projects' }
      its(:resource_name){ is_expected.to eq 'project' }
      its(:plural_resource_name){ is_expected.to eq 'projects' }
      its(:full_resource_name){ is_expected.to eq 'space_project' }
      its(:plural_full_resource_name){ is_expected.to eq 'space_projects' }
    end
  end

  describe :model_class do
    subject{ ModelBase::MetaModel.new('Project') }
    its(:model_class){ is_expected.to eq Project }
  end

  describe :columns do
    subject{ ModelBase::MetaModel.new('Project').columns }
    it{ is_expected.to be_an Array }
    it{ is_expected.not_to be_empty }
  end

  describe :all_dependencies do
    subject{ ModelBase::MetaModel.new('IssueComment') }
    its(:all_dependencies){ is_expected.to be_an Array }
    let(:issue_comment_depdency_res_names){ %w[issue project user] }
    it{ expect(subject.all_dependencies.map(&:full_resource_name)).to eq issue_comment_depdency_res_names }
  end

  describe :factory_bot_let_definitions do
    subject{ ModelBase::MetaModel.new('IssueComment') }
    it do
      expected = [
        "let(:user) { FactoryBot.create(:user) }",
        "let(:project) { FactoryBot.create(:project, owner: user) }",
        "let(:issue) { FactoryBot.create(:issue, project: project, creator: user) }",
      ]
      expect(subject.factory_bot_let_definitions('')).to eq expected.join("\n")
    end
  end

end
