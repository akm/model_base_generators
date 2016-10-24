require "spec_helper"

describe ModelBase::ColumnAttribute do

  context 'ProjectAssignment' do
    let(:project){ ModelBase::MetaModel.new('ProjectAssignment') }
    describe :project do
      subject{ project[:project_id] }
      its(:column){ is_expected.not_to be_nil }
      its(:required?){ is_expected.to eq true }
      its(:type){ is_expected.to eq :integer }
      its(:ref_model){ is_expected.not_to be_nil }
    end
    describe :user do
      subject{ project[:user_id] }
      its(:column){ is_expected.not_to be_nil }
      its(:required?){ is_expected.to eq true }
      its(:type){ is_expected.to eq :integer }
      its(:ref_model){ is_expected.not_to be_nil }
    end
    describe :started_at do
      subject{ project[:started_at] }
      its(:column){ is_expected.not_to be_nil }
      its(:required?){ is_expected.to eq false }
      its(:type){ is_expected.to eq :datetime }
      its(:ref_model){ is_expected.to be_nil }
    end
    describe :finished_at do
      subject{ project[:finished_at] }
      its(:column){ is_expected.not_to be_nil }
      its(:required?){ is_expected.to eq false }
      its(:type){ is_expected.to eq :datetime }
      its(:ref_model){ is_expected.to be_nil }
    end
  end

end
