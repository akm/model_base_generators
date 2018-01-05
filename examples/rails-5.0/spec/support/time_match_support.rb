# frozen_string_literal: true
module TimeMatchSupport
  def localized_time_re(time_str)
    Regexp.new(Regexp.escape(localize(Time.zone.parse(time_str))))
  end
end

RSpec.configure do |config|
  config.include TimeMatchSupport
end
