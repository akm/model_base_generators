require 'rails_helper'

<% module_namespacing do -%>
RSpec.describe <%= class_name %>, <%= type_metatag(:model) %> do
end
<% end -%>
