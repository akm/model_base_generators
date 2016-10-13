module GeneratorSpecSupport

  def assert_expectation_file(path, expectation_filepath = nil)
    expectation_filepath ||= File.expand_path("../../../examples/#{path}", __FILE__)
    expectation_filepath.sub!(/_spec\.rb\z/, '_spek.rb')
    assert_file(path, File.read(expectation_filepath))
  end

end

RSpec.configure do |config|
  config.include GeneratorSpecSupport, type: :generator
end
