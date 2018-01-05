module GeneratorSpecSupport

  def assert_expectation_file(path, expectation_filepath = nil)
    expectation_filepath ||= File.join(EXAMPLE_APP_PATH, path)
    assert_file(path, File.read(expectation_filepath))
  end

end

RSpec.configure do |config|
  config.include GeneratorSpecSupport, type: :generator
end
