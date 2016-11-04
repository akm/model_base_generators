<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the <%= class_name %>Helper. For example:
#
# describe <%= class_name %>Helper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
<% module_namespacing do -%>
RSpec.describe <%= class_name %>Helper, <%= type_metatag(:helper) %> do
end
<% end -%>
