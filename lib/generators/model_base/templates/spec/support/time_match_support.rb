<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
module TimeMatchSupport
  def localized_time_re(time_str)
    Regexp.new(Regexp.escape(localize(Time.zone.parse(time_str))))
  end
end

RSpec.configure do |config|
  config.include TimeMatchSupport
end
