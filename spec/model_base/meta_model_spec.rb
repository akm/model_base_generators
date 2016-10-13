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

  describe :column do
    subject{ ModelBase::MetaModel.new('Project').columns }
    it{ is_expected.to be_an Array }
    it{ is_expected.not_to be_empty }
  end

end
