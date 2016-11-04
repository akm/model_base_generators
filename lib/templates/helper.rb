<%- unless ModelBase.config.frozen_string_literal.nil? -%>
# frozen_string_literal: <%= ModelBase.config.frozen_string_literal.inspect %>
<%- end -%>
<% module_namespacing do -%>
module <%= class_name %>Helper
end
<% end -%>
