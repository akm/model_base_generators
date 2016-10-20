module GeneratorSpecSupport

  def assert_expectation_file(path, expectation_filepath = nil)
    expectation_filepath ||= File.expand_path("../../../example/#{path}", __FILE__)
    assert_file(path, File.read(expectation_filepath))
  end

end

RSpec.configure do |config|
  config.include GeneratorSpecSupport, type: :generator
end
