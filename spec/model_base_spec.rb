require "spec_helper"

describe ModelBase do
  it "has a version number" do
    expect(ModelBase::VERSION).not_to be nil
  end
end
