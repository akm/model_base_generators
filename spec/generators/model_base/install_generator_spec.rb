require 'spec_helper'

Rails::Generators.lookup(["model_base:install"])

describe ModelBase::InstallGenerator, type: :generator do
  destination File.expand_path('../../../tmp', File.dirname(__FILE__))
  arguments %w(verbose)

  before { prepare_destination }
  before{ run_generator [] }

  context "valid" do
    ModelBase::InstallGenerator::FILES.each do |f|
      it(f){ assert_expectation_file f }
    end
  end
end
